Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6AF517516
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 18:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386428AbiEBQzo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 12:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386398AbiEBQyq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 12:54:46 -0400
X-Greylist: delayed 37914 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 May 2022 09:51:15 PDT
Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch [185.70.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB276245
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 09:51:15 -0700 (PDT)
Date:   Mon, 02 May 2022 16:51:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail3; t=1651510273;
        bh=1cdsfMftj12LEBac8HBQx+n4p8srQA9y/BR1ddAY6tw=;
        h=Date:To:From:Reply-To:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=TsLPgpjU3h16xJnnB/ZCWSI3VVuCFF/0u1w2DzuSuG3te5MB80TP3LN2cK9p8hJiM
         L1xr8t/Sd7kogu6VBOx6mykciLmvKIRSqjcyN9yiM8CPoWxoC/SLiFv9/oPBIr363v
         e7a4OviVDEqI1ZO3wfoYmK+jvZyQcRI0Y6y+Ey3zaCNEnOFg2D11QxSv4sB+nOo8pL
         PqyJnjynikGlB5Tw2z1kvkRLSoMMGxZCx13Qv786ERQr2rtoZiYKh0ooWgI3pCLZpS
         Q8tkfo7vjrbDpVm/3QPRHYFcXDTSvYfpRhXPefovKYZSeUOvP6XMRgOOpsejEZmrh3
         CkEHizSQ0owGQ==
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Neko-san <nekoNexus@proton.me>
Reply-To: Neko-san <nekoNexus@proton.me>
Subject: Re: [Help?] "errors" found in fs roots
Message-ID: <6mLGKEfkxtWN7Z-dUziEgizAdclo0RftcmcYG74zaXY1F0hgqeknrqKc5CGo0IjliM7_2BAp515jR3X1OJ5GzqTG8-QWOPDe56goD2dSZm8=@proton.me>
In-Reply-To: <8hH0EBKfKaciK1_cX-iqDutaxznwCYo_pJp5SCgfxC-qGnmQ6-YWHJx69Mi0N2akRh-OZOedEPGeHCUqguEnMXM8Kqz13pHUxZw6hwp05AM=@proton.me>
References: <8hH0EBKfKaciK1_cX-iqDutaxznwCYo_pJp5SCgfxC-qGnmQ6-YWHJx69Mi0N2akRh-OZOedEPGeHCUqguEnMXM8Kqz13pHUxZw6hwp05AM=@proton.me>
Feedback-ID: 45481095:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Is no one willing to help with this?

------- Original Message -------
On Monday, May 2nd, 2022 at 6:19 AM, Neko-san <nekoNexus@proton.me> wrote:


> Hello; I'm having a bit of trouble resizing my BTRFS partition...
> It mounts fine, but "btrfs check" reports errors and prevented my GUI dis=
k management software from performing the operation.
>
> I would appreciate help in figuring out how to fix this without destroyin=
g ~2 TBs of data... please. >_<
>
>
> ```
> neko-san@ARCH ~> btrfs check --readonly --progress /dev/sda3 &> btrfs-che=
ck.log
>
>
> neko-san@ARCH ~> uname -a
>
> btrfs --version
> btrfs fi show
> btrfs fi df /mnt/extraStorage/
> sudo dmesg > dmesg.log
>
> Linux ARCH 5.17.2-256-tkg-pds-llvm #1 TKG SMP PREEMPT Wed, 13 Apr 2022 20=
:30:30 +0000 x86_64 GNU/Linux
> btrfs-progs v5.17
> Label: none uuid: 5761f276-9f47-4195-a5b2-c21ff4f3fea5
> Total devices 1 FS bytes used 181.35GiB
> devid 1 size 198.11GiB used 198.11GiB path /dev/nvme0n1p2
>
> Label: 'extraStorage' uuid: 9d14e17d-66d4-41e7-95a4-8125f75b4d2b
> Total devices 1 FS bytes used 2.16TiB
> devid 1 size 2.18TiB used 2.18TiB path /dev/sda3
>
> Data, single: total=3D194.01GiB, used=3D179.33GiB
> System, single: total=3D4.00MiB, used=3D48.00KiB
> Metadata, single: total=3D4.09GiB, used=3D2.03GiB
> GlobalReserve, single: total=3D370.78MiB, used=3D0.00B
> doas (neko-san@ARCH) password:
> neko-san@ARCH ~>
>
> ```
> (The logs are too big for this email, so here's a cloud link:
> https://mega.nz/file/QrJRUQ5D#NCt5T6dpwS8VGWOrxPGdFK2M9nkURJ2ekH-YugFvVuc=
 )
