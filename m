Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9927256FA
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 10:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbjFGIJ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 04:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbjFGIJZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 04:09:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C3795
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 01:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686125362; x=1686730162; i=quwenruo.btrfs@gmx.com;
 bh=BL3IYgPTxkg+zRdQ7Ox1X1ksUMfqmkV5lFtCiwTHO8Q=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=BZc1daH2s9zpiAT9VHy+/CQm9O/gG+FeBp+2gQeuAqPt8McFy4hdE2wz6dih54ibtI+FVv2
 iXIW3LHNeEsCEl/ZPAoBo1VzhHht36suuePhmboZis0dBOCW56L4YNFR2/jJ7KlDa9KOpMjvD
 kJlz70B7C13LwFn6hnvU9MvqcMM5W1N1L1TrYZ3r1nM7LsZmikpFjOMt/sOXyFIpeBn3uRMo7
 448DjGXHUIB/5YE2QgfA/QAouzijH/D+l4c8UJ3xCi2FXU3pRjMnJShaPvYAM0XALoCX2U0pY
 t9Vke+RjfNqOqUMqCoETyKTQgnY1MGefFj+JHAp1zMYdNyaNhRZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MORAU-1qWhdn14UI-00Pz23; Wed, 07
 Jun 2023 10:09:22 +0200
Message-ID: <01d99c0f-da3f-0d2a-8437-b065bc610eb3@gmx.com>
Date:   Wed, 7 Jun 2023 16:09:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: parent transid verify failed + Couldn't setup device tree
Content-Language: en-US
To:     Massimiliano Alberti <xanatos78@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CALgeF5=8Www=aG8=6XXTYsiD-A=dBdGUN8Drj=h4d92yoZNXHw@mail.gmail.com>
 <cf225ad6-69f4-a339-2e7b-42f094a7b5fb@gmx.com>
 <CALgeF5ksBx0+0v8yGu3XECPkDZJZB0tBAeHt+1MUAXLEa67QPw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CALgeF5ksBx0+0v8yGu3XECPkDZJZB0tBAeHt+1MUAXLEa67QPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OaMO9zV5Ec9SB+/LkdwgYXXE+2AMs84qdtbyT33ocU2BlfkGZCh
 ydNrceiISYN4Fg/n145ddND9WCNOY2P24deR6vRCPlkBrEF22TMjVY56V6UjT+SO2EHAEFj
 F8spYnt3asoQvTkHYYnkEjmCyv9XoFtl7baudCcwcY+NmXGU6MN++91qog2Fs1wmp7CnAFt
 gnwsjBncjfL0rCeR6ADfQ==
UI-OutboundReport: notjunk:1;M01:P0:TExlc0gxLy8=;/bgoGoYCclxpx8tdkOimu5x3GLF
 bfcd3Q+HWdYEc4xtweReWfqMLnSAcoeVZuNy/CyB8kiDNu0Bm9vtkcEQN2jtkvkh/aJ3N2VzZ
 l/Svg7P1GUrL7+WjrrcUz+vdXjYdRat1eoB+hDH7FeqkqOM4tZR5NApDW+Mcu2wXtlNlx7R7a
 mKXlOM8FzhS0DCwj3YQUXGcHsNc+M+39MO03pVZVMMlM3Kr6ivUj5jaqb4jMx9VK8RgEFEWuk
 3fOffWQ/b++fdVUqZiszxLcawGrf5bj1MvNlrcGiyTZbWjmeNHg6DqiAUhutUNtloSOwjVqa/
 tf48+xlPATyuts+o+++wnCtiX+Nif6wqEsREcLkOc9i4hI9RpGNxidSERAHYFbxD2dnefACUu
 /c16RR5qj+e2efqOQiDYowkMTNoOln9NaE2HzAtQP455AIb2sP2HATNZ15q2qpULFsb4LF4Cz
 JeV+sw05y2aFyHBuTSsWI64Lt2XUCKLClExtcSh0P5jST8Aw81+01Ji/W10C68DZxQsJ/AVFL
 BXqfbsAkQkGUmhq+vIZLMEyg7YqpbszqP42/CrT0/hgXDUvqgm1UV7lo4jyPmqjos+m7gf6ri
 FpLXUaAKFHFeS8gaHp299cE+B/jpPJDiCvN4OIol635JJRVYulPfoJAvfbelf5PqzrJX4irNf
 UOZRWRm90OFNyo4A9SK3QlN8Znac5mB9hFOmy7z+Q1Y2bmpo7c1DhxM4NwYBgA/EPJHOIdtvr
 xKIniQvXzU6cli0l0ovISF1NmCUOD1v1uUa84TJU7XeEPuWvvDUbX4ER+vARktPlg1xNC8FMl
 0H9UPxTExcOTVSgqs76BZuEU8FPX2uNwotr9j0LF7AKrDyhzLxEOoYChQMXI55Z0h3dSqFecY
 Dx7Sum1F1wmW1BjHSwYFRDLaa6boE/c9PSag1uxNdrNSQCvsEJ34bwVn3T/FXjJFf9iEhPPHU
 lWHgtj5WYkLyYbeNxkBu8h0Lcsg=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/7 16:06, Massimiliano Alberti wrote:
> Kernel 6.3.6 (just upgraded)
>
> root@ebuntu:~# mount -t btrfs -o rescue=3Dall /dev/sdb1 /mnt/sdb1
> mount: /mnt/sdb1: wrong fs type, bad option, bad superblock on
> /dev/sdb1, missing codepage or helper program, or other error.

Dmesg for that failure please, but I guess it no longer matters, as it's
mostly some critical trees got corrupted by transid mismatch.

>
> I can use the btrfs rescue (no hypen), but how?

I mean "btrfs-restore".

> The superblock is ok,
> so the options that seems promising are the chunk-recover and the
> zero-log

Superblock is really only an entry point, if most of the trees has
transid mismatch, the valid super block itself makes no help.

Thanks,
Qu
