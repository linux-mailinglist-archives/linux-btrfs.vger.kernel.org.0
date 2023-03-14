Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7273E6B9D34
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 18:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCNRjm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 13:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCNRjl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 13:39:41 -0400
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41538CC24
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 10:39:39 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id D90D510F393; Tue, 14 Mar 2023 13:39:08 -0400 (EDT)
References: <ba9fb1c9-ccbc-4b93-92f9-a8c17ffab7f6@business-insulting.de>
User-agent: mu4e 1.7.12; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     4censord <mail@4censord.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Corruption with hibernation and other file system access.
Date:   Tue, 14 Mar 2023 13:36:32 -0400
In-reply-to: <ba9fb1c9-ccbc-4b93-92f9-a8c17ffab7f6@business-insulting.de>
Message-ID: <87mt4f9qrn.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_20,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


4censord <mail@4censord.de> writes:

> As for how i think the corruption happened:
>
> This is the rootfs from a laptop. Btrfs in a luks container on a normal partition.
> Only other thing on this disk is a efi partition.
>
> The system was in hibernation while some maintenance took place.
>
> The system was booted via an external medium to make some changes to the
> bootloader. For this, the rootfs had been mounted rw, but no mayor
> changes took place. Most writes should have been on a separate EFI partition.

You must never boot into a different kernel while one is hibernated, at
least if there is any possibility that the other one will try to mount a
filesystem that is mounted by the one in hibernation.  If you do, you
MUST NOT attempt to resume the hibernated system or there will be fire,
exposions, and death.

