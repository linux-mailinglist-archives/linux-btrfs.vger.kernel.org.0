Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA7B51834A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 13:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbiECLeX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 07:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiECLeV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 07:34:21 -0400
Received: from ssl1.xaq.nl (ssl1.xaq.nl [45.83.234.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FF11CFDB
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 04:30:48 -0700 (PDT)
Received: from kakofonix.xaq.nl (kakofonix.utr.xaq.nl [192.168.64.105])
        by ssl1.xaq.nl (Postfix) with ESMTPSA id A927A82F95
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 13:30:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucassen.org;
        s=202104; t=1651577445;
        bh=nwpTszK8zI5nB0whWP52V2nqKYmFFsQcCFI6qxO46ac=;
        h=Date:From:To:Subject:In-Reply-To:References:Reply-To;
        b=uMVIppQ+xDXjLaVPryxj4teg8qrHA+ThEbnLKy/8AOsux5O1stRafF8BF3tflykyn
         aeOGXV2cHnN37mWOU0CxydOWfJvAbfp+q6dvSQOZ+R8FrwH1X/H/AbfNau76mnj43x
         I//vBTozK4Zs2T1A0mgt7iJpLv7LzTY9fVRb+fRzdMYUKVDD0EIaAmbwIkFrsMAZ6w
         U4SsGj8HQngoWTQAkwbhzuDbP24EhQ8UisMDvL+wYVhNY86N5RSDWRPcdXYclXopT4
         CxvEOev2zwuru2t174La618YV24f+NjvFbzeRTbW0q603E/Y5h5D7JIS8fKu7Uv+0N
         G0uH61WhncEWQ==
Date:   Tue, 3 May 2022 13:30:45 +0200
From:   richard lucassen <mailinglists@lucassen.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: cannot mount btrfs root partition
Message-Id: <20220503133045.594324090c894eba9d18b858@lucassen.org>
In-Reply-To: <d018c2e9-b07c-6a2d-9819-810ce81ad24c@gmx.com>
References: <20220503102001.271842da4933a043ba106d92@lucassen.org>
        <20220503083206.GI15632@savella.carfax.org.uk>
        <20220503104550.16d2465877beb89f713485c2@lucassen.org>
        <20220503090842.GJ15632@savella.carfax.org.uk>
        <20220503113427.3a192c5daf6197aa3b6c93bc@lucassen.org>
        <d018c2e9-b07c-6a2d-9819-810ce81ad24c@gmx.com>
Reply-To: linux-btrfs@vger.kernel.org
Organization: XAQ Systems
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 3 May 2022 17:54:54 +0800
Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> > About the option to specify the devices explicitely, is this the
> > right syntax to tell the kernel what to do?
> >
> > append="root=/dev/sda6 rootflags=device=/dev/sda6,device=/dev/sdb6"
> 
> Since you only have two devices in the fs, you can skip the one in the
> root=, just by:
> 
> root=/dev/sda6 rootflags=device=/dev/sdb6
> 
> You can test with all devices forgot:
> 
> # btrfs devices scan -u /dev/sda6
> # btrfs devices scan -u /dev/sdb6
> # mount /dev/sda6 -o device=/dev/sdb6 /mnt/btrfs

Thnx Qu, but Hugo is right: to boot btrfs raid1 you need userspace on
initramfs, and these options are for /etc/fstab, not for use at boot
time when there is no / device available.

R.

-- 
richard lucassen
https://contact.xaq.nl/
