Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5949B5B52C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 05:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiILDEN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Sep 2022 23:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiILDEL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Sep 2022 23:04:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F78024F34
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Sep 2022 20:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662951845;
        bh=ZxKuryWiUKPBvswuq6fTjoGeKanfXSEjO5l5CHdO2oA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=HSe9X1Ni5hwhVENygGCXG3LCJvKxBiegffCLyV5jcUgTpfdpX85i2J65cf+tL1hxb
         hvSk7kx9XGClYk/BWEaCY4pfWgB3kAVzZgo1lx570DLUcNvuKvtNYekrr3ppouKern
         JMD5DUkX8oTEUmWjIEJcesD7AYgtFKj+A05F/+E4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8GQs-1pSgZ20e9Y-014Bgl; Mon, 12
 Sep 2022 05:04:04 +0200
Message-ID: <40777f8c-1612-7df5-4184-1eff2971cc05@gmx.com>
Date:   Mon, 12 Sep 2022 11:04:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: how to disable block-group-tree feature?
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20220912110144.A85A.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220912110144.A85A.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nly0WIwdcvXRfWK4+MiZnGnPRVHUCl35fGLXTOU5vwdanHTM1yi
 O/sQIIK1qEMuZqluFKac2clncsKr+FcXS8X2+k5CrchL0GBbBn6dSYve90mUOCjjgHUWYM/
 e3N+XRdvmSV2RmlhD9NTj4dPeL5X+GM116LcX8oCyEPDDS1/U8px+535c5E6jnV3DVakO+K
 1DKJtMJVKFk6gvhQ9Fhqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qSsGtk1Tjaw=:ekm8SCid38ZMF/UmVFpIF4
 RM68fFgcrKICNS+rMiFm1cgbmn0vfEQe+1Gw/DhZw6qWqO8zv4y8Dk+epDyghOhiRq5r0RO31
 gOAro5/TUvylMkAlsMAc0E6cdrLQz2g0hjoCl+IEuk41pdln+W0dL2XQwrTc31fX2b8XTxe5T
 HtJL+ZQCUZt5E5l1zCB3cRObEzjF5pKvZtX/I1RmQY9MlohEwh20eBiOi5/RCfi+rBEMWyyL8
 baWo+853I4bA2XQPzV4806R4n8Egeg7ZxFTNIlICs4D2gxeisY1CkNljz8wVA89fmwN9/LsAG
 iHnAKbi26LB8lRBp+wiVks9wJcFr90gteRaPwssI/FxCHz6XUPltngdgzthdfqcLhT2F/I6RI
 WlzlkiL8aJthxBFaub4Io6uDqjcY3Jt4sYpVar6PWCaqkMxZMtSumS3fZvgQVDii1k8acWrje
 FB0VPGycb3eWR/SeSjMytU17Og9TwmyAF506W4cvAu3HaHhtFcDyNPqoxcVNU8J6ZDI3cUCCS
 MaC9MliVazWUvJD6L/4Ji1ciydv2TCFIB5pERVzxUls8AFWzf199AdhP+IHqkhL6xQE7YXEiI
 nw2WbNfDxz/WQhM1f6xC9XWU/Q4Ays5kWwHMGqOpTbPIt9/eFKbWD6k4uLOp9RTxqi9L0QhW+
 6a6xCphRiDaWX+fxezAAJiviG+Sz8QkRDanB5wyfoW1PppFfhkvsqPHtAOmpWDLXH1CeQ826c
 Eh2FAshfD69nnqSlxZEU4ZG8xtht9GIB6rZg2H8A/bfVnuebaWOfrD5mFT2VB7mX/Mq7I7HBd
 OojjgFRuSvAF1XCC75rqi2BB+T++LUhROtyLn+ntJPThjs8OZPUHyoi6vLwLc+mHSDHZnM/MP
 sQP326H3DDElRwqdvaZesiCRcEviEKsQKM5c14wKjCO/pOC23TxWb0srUK189LooiS0//1937
 8DzNl/P1QcfjvAKMELAzNTPMfBLFQxFuUl+1Woip8LgwNw/M6Hgb7ZRgqUxG/9C4x7Dla3LEM
 yue1Zk6sIIRkEkoKMSwgazoT+JUdXDVopmN8ks+EVwk3SNk4elqNyhQcDUncG3GBGmfmC57GS
 qOAdPl7sJLD/rYx4nNTc3Ww+uXpT2px6yxUvl4rGOVMmDxNqaXrnizhdQ7ojediQpThpMMN3y
 ZtKZlbhavQYP9aWiUMs0lbmDnx
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/12 11:01, Wang Yugui wrote:
> Hi,
>
> Is there any way to disable block-group-tree since it is a runtime
> feature?

Check the cover-letter before applying them:

[TODO]
- Add btrfstune support to convert from block-group-tree feature
   The infrastructure is already done.


>
> I tried to 'mount -o clear_cache,space_cache=3Dv2'
> to disable both block-group-tree and fres-space-tree,

Nope, no mount option can change bg tree.

> it failed with the flowing dmesg output.
>
> [ 1400.647031] BTRFS error (device sda1): block-group-tree feature requi=
res fres-space-tree and no-holes
> [ 1400.656251] BTRFS error (device sda1): super block corruption detecte=
d before writing it to disk
> [ 1400.665044] BTRFS: error (device sda1) in write_all_supers:4305: errn=
o=3D-117 Filesystem corrupted (unexpected superblock corruption detected)
> [ 1400.677643] BTRFS warning (device sda1: state E): Skipping commit of =
aborted transaction.
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/09/12
>
>
