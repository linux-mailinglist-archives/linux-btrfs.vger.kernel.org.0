Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C174B02E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 03:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbiBJCAx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 21:00:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiBJB7v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 20:59:51 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A19270D9
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 17:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644456829;
        bh=2IIUSZT8n0fe8kX9jrhCkPwru6F7FOaoCDpmUCgnVHk=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=Zhm/44ON70XAZ5NO1T+PXilX0sKTPCXeWCBEnDBjAQQJFqzvzx6x9JqjlMae9UQRY
         4ISpHBJfAYKBVEZedBxPtdG67jO2OAFXhWP0LvKwl3NFp601WdhuPk/ZlesLUC93lm
         REQVoe3etJweQhSyyJTh+J4bhhdOD4JC3ugl0n74=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MpUUw-1o5aM40UkW-00pvwz; Thu, 10
 Feb 2022 02:33:48 +0100
Message-ID: <51b5c958-1df6-e95e-d394-c95a0863ea0f@gmx.com>
Date:   Thu, 10 Feb 2022 09:33:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     BERGUE Kevin <kevin.bergue-externe@hemeria-group.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <776a73dbf91d4518a36b465ac9ac2d5a@hemeria-group.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Root level mismatch after sudden shutdown
In-Reply-To: <776a73dbf91d4518a36b465ac9ac2d5a@hemeria-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/MD11W+tjGGAz11DgvIlZzcrDRe1o5UfPOL4PDcO+bvY70qkUvP
 Zts2w6WFBMN+F6OL9949e2bdXTopWJ3trZXy7JNkcUW0qSnU00N2p1Lhp0j8z7sigmChWST
 7k1/p0NajMxCUnzXqf5SkrHcsmQilNg5kBGNpa9fQo0RGWtrlv9ccB9YSKtn6V09PN4qRAs
 e2sh8Jtj5nR7BPsmoBAmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:scp7S/5rMjA=:6bYjsCcnrClAjtyoxEoyda
 qhHDPeCMwGgVAhmJid1Kz2vT6BfwlCORIebICm+ZZJ9FmbTOuLewBQkb8uJEiwI22TFWHaIJe
 AuWTVQ+iI2TkShDj/uqOYnfILSEiCwtQvUslFMdQr33LFIvdgFeVHRjaG8wzMWni3iz/ekggA
 QWks/ROXMl6XP9rVDSz57xPAqvYOPRkOWvieD+7J1uArcaKrUM3Q60RhkVdGxBtGbPyR916ox
 9HCd1U4fnjmH+tkg0LVuKVRw1ttSOn45AaXKPIRCuVq4AbXxBjhBZABXXn8e3Eql2kO3UgWg6
 F81Fb2dpQGwcz7gbNWswLgCtwDgnzPkWyvC0FzocIGRcudIR1gXhYTzJpqsl0s/iv0tmrW/e/
 n9zEAyV57/09Vi7rsmogse4WQHJ/9zX6vQb5gJaAg3+QbT/Uitn9/4PYi8m0sQTOMUG3QOjd9
 OaLQftCsWFTuETt1at6e3DINO3srcy8XTVb3OyxbWwavNfs/BH+wq+qy9pkDhi9s5SypNxCHk
 zPefZSQK3sWboxVoZxNzcKYDuBDlIgbPzQu41Qe5kcrRuXzavxgNRefG/YJY9f1nLLSuT1q0+
 G8iPBZmM1yrSEMNtC5q5F/62xgkVx0rba//OkUSREXsUyhAiGUmpIS1d5u3ESnUIJ/8buH3OQ
 0sjiHaWccLnsUQgajQuzEQu1hqD4jeg18VJAfYix1DGvZtV4PcvytmIRuJ1bZ+mM8Ltv0OYPg
 H95HRxWDNHyfAcxOUnagWxL02u9Qpg64UoI9I3j+yrJSdej3YB1EDnUfsE6hs84oJvuvDHdNr
 5el7nfnrhqSKK5YAZSo9jQih0GLOnQ427jzDKgsdWsruOfSEUqCezOyoNBfGRASHrFV/nv6IM
 rdSGoyn+XCts7AG3cTtkQnkhPSxcvDGn2/iVTXseTd0Efk/xqK8FwLc2bDFXlQcE/wuCLNfDp
 M2m2Ya9BEztsFryPuHl4UeZ+ktrVDW1v3n7hsAXwK0N+lcJW0eGq+O/UK0NDly4GfbxGDMSjt
 fsUsUEo8EXGlOcrME8Xv4/3lUcHgwA62IFD6tzLSKro6H5Xm7ZaCOHIoydMJQPDPDDJm/wGAh
 LQbLzUuISRIxxk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/9 18:53, BERGUE Kevin wrote:
> Hello everyone.
>
>
> After a sudden shutdown my btrfs partition seems to be corrupted. After =
a few hours of reading documentation and trying various repair methods I f=
ound an error message I can't find anywhere so I'm sending it your way hop=
ing you can at least explain what the issue is. The disk was running with =
linux 5.16.5 at the moment of the crash, my recovery environnement is a li=
nux 5.15.16 machine with btrfs-progs v5.16.
>
>
> To retrace my steps a bit:
>
> - I tried to mount my partition normally:
> # mount /dev/mapper/SSD-Root /mnt/broken/
> mount: /mnt/broken: wrong fs type, bad option, bad superblock on /dev/ma=
pper/SSD-Root, missing codepage or helper program, or other error.
>
> - I then looked at the relevant logs from dmesg:
> # dmesg
> [ 2118.381387] BTRFS info (device dm-1): flagging fs with big metadata f=
eature
> [ 2118.381394] BTRFS info (device dm-1): disk space caching is enabled
> [ 2118.381395] BTRFS info (device dm-1): has skinny extents
> [ 2118.384626] BTRFS error (device dm-1): parent transid verify failed o=
n 1869491683328 wanted 526959 found 526999
> [ 2118.384900] BTRFS error (device dm-1): parent transid verify failed o=
n 1869491683328 wanted 526959 found 526999

Transid mismatch, and it's newer tree blocks overwriting old tree blocks.

This means two possible situations:

- The SSD is lying about its flush/fua opeartions
   This means, the SSD firmware doesn't really write all its data back to
   its NAND when it reports flush/fua operations are finished.
   This mostly means the SSD is not reliable for any filesystems.

   Although traditional journal based filesystems may have a better
   chance to survive.

- Some corrupted v1 cache makes btrfs to break its CoW checks
   This can only happen for v1 space cache, and is pretty tricky to
   happen, as v1 cache has its own checksum.

   And now v2 cache is the default for newly created btrfs.

- Corrupted extent tree screwing up metadata CoW
   Normally it would cause transaction abort in the first place though.

- Complex storage stack added extra points to cause FLUSH/FUA problem
   If you're using things like LVM/LUKS/Bcache, it's more complex and
   any stack in the middle can cause FLUSH/FUA problem if there is some
   bugs.

Mind to share the following info?

- Storage stack
   From hardware disk to the top level btrfs, all things like LVM/LUKS
   /Bcache would help us to understand the situation.

- SSD model
   To see if it's some known one to have FLUSH/FUA problems.

Thanks,
Qu


> [ 2118.384905] BTRFS warning (device dm-1): failed to read root (objecti=
d=3D4): -5
> [ 2118.385304] BTRFS error (device dm-1): open_ctree failed
>
> - After some reading about the "parent transid verify failed" errors I t=
ried to mount the volume with the usebackuproot flag:
> # mount -t btrfs -o ro,rescue=3Dusebackuproot /dev/mapper/SSD-Root /mnt/=
broken/
> mount: /mnt/broken: wrong fs type, bad option, bad superblock on /dev/ma=
pper/SSD-Root, missing codepage or helper program, or other error.
> And the dmesg content:
> [ 2442.117867] BTRFS info (device dm-1): flagging fs with big metadata f=
eature
> [ 2442.117871] BTRFS info (device dm-1): trying to use backup root at mo=
unt time
> [ 2442.117872] BTRFS info (device dm-1): disk space caching is enabled
> [ 2442.117873] BTRFS info (device dm-1): has skinny extents
> [ 2442.123056] BTRFS error (device dm-1): parent transid verify failed o=
n 1869491683328 wanted 526959 found 526999
> [ 2442.123344] BTRFS error (device dm-1): parent transid verify failed o=
n 1869491683328 wanted 526959 found 526999
> [ 2442.123348] BTRFS warning (device dm-1): failed to read root (objecti=
d=3D4): -5
> [ 2442.124743] BTRFS error (device dm-1): parent transid verify failed o=
n 1869491683328 wanted 526959 found 526999
> [ 2442.124939] BTRFS error (device dm-1): parent transid verify failed o=
n 1869491683328 wanted 526959 found 526999
> [ 2442.124942] BTRFS warning (device dm-1): failed to read root (objecti=
d=3D4): -5
> [ 2442.125196] BTRFS critical (device dm-1): corrupt leaf: block=3D18698=
63370752 slot=3D97 extent bytenr=3D920192651264 len=3D4096 invalid generat=
ion, have 527002 expect (0, 527001]
> [ 2442.125201] BTRFS error (device dm-1): block=3D1869863370752 read tim=
e tree block corruption detected
> [ 2442.125500] BTRFS critical (device dm-1): corrupt leaf: block=3D18698=
63370752 slot=3D97 extent bytenr=3D920192651264 len=3D4096 invalid generat=
ion, have 527002 expect (0, 527001]
> [ 2442.125502] BTRFS error (device dm-1): block=3D1869863370752 read tim=
e tree block corruption detected
> [ 2442.125508] BTRFS warning (device dm-1): couldn't read tree root
> [ 2442.125806] BTRFS critical (device dm-1): corrupt leaf: block=3D18698=
66401792 slot=3D117 extent bytenr=3D906206486528 len=3D4096 invalid genera=
tion, have 527003 expect (0, 527002]
> [ 2442.125808] BTRFS error (device dm-1): block=3D1869866401792 read tim=
e tree block corruption detected
> [ 2442.126174] BTRFS critical (device dm-1): corrupt leaf: block=3D18698=
66401792 slot=3D117 extent bytenr=3D906206486528 len=3D4096 invalid genera=
tion, have 527003 expect (0, 527002]
> [ 2442.126175] BTRFS error (device dm-1): block=3D1869866401792 read tim=
e tree block corruption detected
> [ 2442.126184] BTRFS warning (device dm-1): couldn't read tree root
> [ 2442.126599] BTRFS error (device dm-1): open_ctree failed
>
> - I then tried a check:
> # btrfs check /dev/mapper/SSD-Root
> Opening filesystem to check...
> parent transid verify failed on 1869491683328 wanted 526959 found 526999
> parent transid verify failed on 1869491683328 wanted 526959 found 526999
> parent transid verify failed on 1869491683328 wanted 526959 found 526999
> Ignoring transid failure
> ERROR: root [4 0] level 0 does not match 1
>
> Couldn't setup device tree
> ERROR: cannot open file system
>
>
> I think the "root [4 0] level 0 does not match 1" error is the real cupr=
it but I can't seem to find any info on this message anywhere. I tried a b=
unch of other commands including:
> - btrfs rescue zero-log
> - btrfs rescue chunk-recover
> - btrfs check --repair
> - btrfs rescue super-recover
> - btrfs check --repair with the tree root found by btrfs-find-root
> - btrfs check --repair --init-csum-tree --init-extent-tree
> - btrfs restore
>
> I'm aware I probably executed some commands that don't make a lot of sen=
se in my context but all of them failed with either the "root [4 0] level =
0 does not match 1" message or a more generic "could not open ctree" or eq=
uivalent.
