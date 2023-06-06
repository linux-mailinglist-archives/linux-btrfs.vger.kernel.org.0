Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C70E724D70
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 21:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbjFFTqZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 15:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjFFTqK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 15:46:10 -0400
Received: from len.romanrm.net (len.romanrm.net [91.121.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370541FDB
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 12:45:30 -0700 (PDT)
Received: from nvm (nvm.home.romanrm.net [IPv6:fd39::101])
        by len.romanrm.net (Postfix) with SMTP id 1B75840176;
        Tue,  6 Jun 2023 19:44:44 +0000 (UTC)
Date:   Wed, 7 Jun 2023 00:44:43 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: can i delete a snapshot with rm -rf ?
Message-ID: <20230607004443.58b9395c@nvm>
In-Reply-To: <PR3PR04MB73408FC92E78BEFF8E85C395D652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB73408FC92E78BEFF8E85C395D652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 6 Jun 2023 19:34:36 +0000
Bernd Lentes <bernd.lentes@helmholtz-muenchen.de> wrote:

> i'm pretty sure having read that this is possible. And in some scripts i do it this way.
> But now i found on the net to not delete a snapshot with rm.
> 
> Cab you help me to clarify that ?

Yes you can, but it is not the optimal way.

It would be more time-consuming, and might lead to metadata bloat and
fragmentation, since multiple states of the directory tree over time as the
deletion progresses will need to get recorded and re-recorded in the metadata.

-- 
With respect,
Roman
