Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AB77B79FC
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 10:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjJDI0N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 04:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjJDI0M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 04:26:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10F183;
        Wed,  4 Oct 2023 01:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1696407952; x=1697012752; i=quwenruo.btrfs@gmx.com;
 bh=1vE4u9fiIhwSlNsGs4guEc8aXdvfJd6/n8ClKyaJRsQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=TMC0VBT+kFDxSNgePcDhGsYgmG8UFol3ltJROOJRzAmnSa8sPi7vGHNpBTkDk6uIxUye96vF0cm
 SgDJxg4j8oRYiPhLmgpFNmO9YdtBepOlEHC47NrOCKMB1SOW72xsM7NxNEXBErwnUqVAm6hHPzVe1
 SO1MwIITwKfeg0BMFK8SuUp68Oi7OLTBq1ySx8kBl338cRX2uAflSe4pI0SCNV+ZARpTKVg4h/JOV
 Q734NkST4DUmvWDcCEN6TxK0/kut9S1XdnXEOnn4UBb3P+mbju4zPVburyJmoFcNs0CngE35eucqE
 czOyQstYFBL0RxtWwsA/T6Pxrszl6303ndmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUXpK-1rEO3L2CTw-00QRjh; Wed, 04
 Oct 2023 10:25:52 +0200
Message-ID: <55caa26c-3448-492c-b139-32c756556b34@gmx.com>
Date:   Wed, 4 Oct 2023 18:55:45 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] btrfs: RAID stripe tree updates
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231004-rst-updates-v3-0-7729c4474ade@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20231004-rst-updates-v3-0-7729c4474ade@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nusI1HBJB1QeBJJ6h9xeqiHQx3vEWK+I+Z6bOwVU64lzVOl26Fh
 PbzD/nmfgfLhzrV6VeUV9Qlu+14FEv1fz2V6j51jE9K+1+OCe28KrrECMhazIkTb9q+qr+V
 HRZrFhArDJeZDzsnvU8gFzcSiYt/v0o6CUydVZPWldxIAy3uCDlK4OQaurEdlqQOALdy/S9
 tEnmvxNFFWESiKjlhjHjw==
UI-OutboundReport: notjunk:1;M01:P0:QpJZva4wmk0=;QZA7xoqwAmwCFIS6vR7L4qrIiy1
 Y8rMDsJ3GHR/KkdNsjXVIRb7mg7LwL9N2JoQOE6gKS7DUGMjM260n15HyTFtQB73yO0WNVyd/
 fkAKgpSHOCyr6hLfJ0+YN4qyGF/FTqx3Rlepo5nx2pilCMpH3hfLd+bIFWHJdO9huxVjzgGGQ
 F41MaQicB/bE3lcFsaecqk1sphEgqx7nLL3GCBPUodD2O2LVFO2O49J5oR+QkUvaQUEHquj07
 NBl04KQUBMeWcNa+4A/iBsUlEqPrbcw8It4okxOdkoiRn81wyg1QJQDdrVkZXXmOM8EwQpkzu
 ulPmZ0/6acaLgOB9qoJ3hCnN6t3izxhXRMlTUOqElX4ZVCtuXi+rjyYbfpWhcyFnbjsB11Oq3
 ZGpFosqI/d9vL+byADfi8MwtuMRhX0u70IwcC/UxL62RVPjsdJ0VUFswPR39SDO+YAV7oLfIs
 yv6rBcJChSNMDjwOSfeCMLWtII3oMs5AbfEOgq7oCvcWTzGGtfIcBQiufOFyfGZ4DiNXDjQpi
 BG4UrrCWZ1GNHOexbk/lf4PQKEumqjt7HP+Er2Q9sDlSeB6KpQQjNzbYVwXwpE7wTx8yeIo9i
 axa82XlZX1M4K6p4kmQkgEPUZs0aVMv0SJ1rzZng2epxPHnRtNZQRFgvnThtwGJPFHCvvkddL
 D2gQkW6+LuFIkcQc2LsdgBCOKuHuHGwsYPcxVRiPVgIAhzkaqMAGxsv3aPio5CPuFuvUXVBMj
 mFtH6QiyDPcwgu768DKo1mbFMv3lA24k01yvJDsJ/PUg3c/rQN9ZbE6yuP/xcAsw7XDTOsG6e
 lkpOrXzjv4/Phowck/j2OJmH3qtxZ+HOt+5A2i2uQRMXmrKzddZC8wwOfV5ATopz78blsSNao
 xELDoKAlRxViPMvJGdxHBdVFUV1HI6MR/CXYRdgowx44BFRYShIC11CQ2jjwHYH8J1aE4tTUE
 V/+tIQbhn1f9BW58FM+ukp0OD8g=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/4 18:26, Johannes Thumshirn wrote:
> This batch of RST updates contains the on-disk format changes Qu
> suggested. It drastically simplifies the write and path, especially for
> RAID10.
>
> Instead of recording all strides of a striped RAID into one stripe tree
> entry, we create multiple entries per stride. This allows us to remove t=
he
> length in the stride as we can use the length from the key. Using this
> method RAID10 becomes RAID1 and RAID0 becomes single from the point of
> view of the stripe tree.

Great the idea can simplify the code.
So I'm very glad I can provide some help on RST.

Although one concern is about the compatibility, but I guess since rst
is still covered under experimental flags for progs, we can more or less
ignore the compatibility for now?

The other concern is, how would those patches be merged, would David
just fold them, and we can check the misc-next, or there would be
another branch for us to view the code?

Thanks,
Qu
>
> ---
> - Link to first batch: https://lore.kernel.org/r/20230918-rst-updates-v1=
-0-17686dc06859@wdc.com
> - Link to second batch: https://lore.kernel.org/r/20230920-rst-updates-v=
2-0-b4dc154a648f@wdc.com
>
> ---
> Johannes Thumshirn (4):
>        btrfs: change RST write
>        btrfs: remove stride length check on read
>        btrfs: remove raid stride length in tree printer
>        btrfs: remove stride length from on-disk format
>
>   fs/btrfs/accessors.h            |   2 -
>   fs/btrfs/print-tree.c           |   5 +-
>   fs/btrfs/raid-stripe-tree.c     | 173 ++------------------------------=
--------
>   include/uapi/linux/btrfs_tree.h |   2 -
>   4 files changed, 7 insertions(+), 175 deletions(-)
> ---
> base-commit: 8d3aed36ee6cac09c7bd6bee6ad67dc2a35615af
> change-id: 20230915-rst-updates-8c55784ca4ef
>
> Best regards,
