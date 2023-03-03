Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A473F6A906D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 06:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjCCFWq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 00:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCCFWp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 00:22:45 -0500
Received: from len.romanrm.net (len.romanrm.net [IPv6:2001:41d0:1:8b3b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D05A14988
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 21:22:44 -0800 (PST)
Received: from nvm (nvm.home.romanrm.net [IPv6:fd39::101])
        by len.romanrm.net (Postfix) with SMTP id CCC0340200;
        Fri,  3 Mar 2023 05:22:39 +0000 (UTC)
Date:   Fri, 3 Mar 2023 10:22:39 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Matt Corallo <blnxfsl@bluematt.me>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Salvaging the performance of a high-metadata filesystem
Message-ID: <20230303102239.2ea867dd@nvm>
In-Reply-To: <59b6326d-42d4-5269-72c1-9adcda4cf66c@bluematt.me>
References: <59b6326d-42d4-5269-72c1-9adcda4cf66c@bluematt.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 2 Mar 2023 20:34:27 -0800
Matt Corallo <blnxfsl@bluematt.me> wrote:

> The problem is there's one folder that has backups of workstation, which were done by `cp 
> --reflink=always`ing the previous backup followed by rsync'ing over it.

I believe this is what might cause the metadata inflation. Each time cp
creates a whole another copy of all 3 million files in the metadata, just
pointing to old extents for data.

Could you instead make this backup destination a subvolume, so that during each
backup you create a snapshot of it for historical storage, and then rsync over
the current version?

-- 
With respect,
Roman
