Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD82077D87F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Aug 2023 04:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241302AbjHPCgG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Aug 2023 22:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241339AbjHPCfl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Aug 2023 22:35:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FEF2682
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 19:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692153315; x=1692758115; i=quwenruo.btrfs@gmx.com;
 bh=dGy6WvjSh+HI8FVX2hbeXMsQcrccyJPUYKmrLEAfSQc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dhlMLQbVUB8oRZW72lm2xqg5INxMq5gumPB5+DiJ4+bRWE1+LBSLRZP/ymyu1y2nmVUyygH
 o/OH6hXpN/AHs9KhcbBpz4mjksUxKZJt88e9Yy2PEalwd0qyGdshCFq7OOles9aQZiuaYUoPf
 DDzjPh9kxMicNPuq7ZH+F5IR2tpLDIsB5iiCOc6fcelKLcUcSSCT/QDNLQb0MAezdyIaWbD6w
 m0lk1vQfxGQfo/tLXQ6Dof6SkRbS42s7Pl6FsNUB1lNnoDq1FJVCOs+Q2b8YGiL0zfEynYPLh
 +zVHHVPx+hnvdEXalDhM+w0EbBAuz/Zf06Ona9+n97V0GRJHlT0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbRjt-1pv7jX3Axl-00bqF6; Wed, 16
 Aug 2023 04:35:15 +0200
Message-ID: <cdc48171-f512-48f0-91e5-7feadb57677a@gmx.com>
Date:   Wed, 16 Aug 2023 10:35:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: scrub: avoid unnecessary extent tree search for
 striped profiles
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
References: <c21b78ee8bcf22f373beeefb8ee47ee92dfe8f03.1692097289.git.wqu@suse.com>
 <202308160248.ZzecEExL-lkp@intel.com>
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
In-Reply-To: <202308160248.ZzecEExL-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9MxqoFdZlIC/W7pGm8TbBc5Bflxg68bF9S1/KhCOmGJ4su7SLYK
 CsrQzIMf7GbbwBqLCSGKPsWd522nmXiZfTZrPCIpA+ITQXTI7n3VuX2kS3SOMdJLSvb6b04
 eU91i04r8JpTvtClGSkPEtWtgogWH0X75pLKXrCWm6Ub1JJyYmluGSxyloLw3guwpmRoEfC
 VV1h5fAH5YXgYmS8PrxRA==
UI-OutboundReport: notjunk:1;M01:P0:1ptItNMnJ/Y=;TCNut/+mKGTZ1eetYhB1Rk9dEDf
 uww+K28x9NcROlAJuP20l0Dkz9wnbcKh7Zd1sYB9r6WTNnfmjlhj6yO2ScOUENLgGf0SXM5zo
 K3F0gdMcnIsLgtYPnsR+mbZQmYwqB5lor5mXbiFjPerOzEXvfmDoU4cU1m0I8wHwmwBsFH3bs
 +YMBRueB8OYXz+ShvlGHwz5VpL29lFpRnOF7cGHTcfrI8RQnSSSRD5kYikZA+5mWte6L2sQr4
 tCU8OGyFPYV1a9M9+9kpocPFR/48fcLjumgD1yrO4k5qpPuW0q1gS/mR+fKVXGe18NBWLXDFa
 9vBaLXMojm26Htdoez0k9r3TEm4DR47zphfft2TAPUAaSyVKExYnzpOW3MplInsf2BWD3GJ/K
 nMrG6bKa7a5XMG9rz9dfhmFCUThZlAIWuhFRCQQLtiohtf+rRIEQKGQx1b9UY88WEsOEa+UUz
 K84AR2jZEuIzLFlnKOpD+/SqLWD3yGrViq+QVDjlsSVl3QcmUXM7iL/p4w6FiRcjne31Im3+J
 9yPUnaDOWsyIqECskSfD+oYpis7qwkJw/7GU9IQ4MLkeZ5LLF2Za7IKpVCs/dQJL7l7vrXyyA
 BKO9a946dVSo3oOMar5IgiVWdzrH1ZNEN4rdykzDDzS3oOaoEju3Y3QIMb4z5S17yCi0TdWbX
 MDeEIZhagpJpBVGerIxM5hL0u8ZGN++K4G3r0yJPIUDiXxLj3h3T+h0akyp32+znvUWQ+UEO+
 3RlN9r3SNgV72RbsRMGU3tETZPrI4DIo3APxC1m5X+J71ovdklMUtkDcWxplTymfLCDTzL3rE
 HDpRuUeJoBmcZMHyUeWAgCIqQ4ZKagUsHa2GhJ26ptMi41uvwlrVT/VPb8oLytAE8SoGlVs0O
 +X/5p+PWE9q/PLYG6a2VAoiEMIQ4S2JD27Z8P5b/WsFPylhOxW/UEmt+0NdILAbPtkqWToeJz
 3iiKeHsoJwSfcmkGWEWu/jWgVOw=
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



On 2023/8/16 02:21, kernel test robot wrote:
> Hi Qu,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on kdave/for-next]
> [also build test ERROR on next-20230815]
> [cannot apply to linus/master v6.5-rc6]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-s=
crub-avoid-unnecessary-extent-tree-search-for-striped-profiles/20230815-19=
1040
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git =
for-next
> patch link:    https://lore.kernel.org/r/c21b78ee8bcf22f373beeefb8ee47ee=
92dfe8f03.1692097289.git.wqu%40suse.com
> patch subject: [PATCH v2] btrfs: scrub: avoid unnecessary extent tree se=
arch for striped profiles
> config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230=
816/202308160248.ZzecEExL-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230816/20230816024=
8.ZzecEExL-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308160248.ZzecEExL-lk=
p@intel.com/
>
> All errors (new ones prefixed by >>):
>
>     ld: fs/btrfs/scrub.o: in function `scrub_stripe':
>>> scrub.c:(.text+0x3d74): undefined reference to `__umoddi3'
>

This doesn't look sane to me.

The same file, scrub.c, already has some other call sites of div_u64()
in scrub_throttle_dev_io():

         if (delta) {
                 long timeout;

                 timeout =3D div_u64(delta * HZ, 1000);
                 schedule_timeout_interruptible(timeout);
         }

So how could this be a problem?

Thanks,
Qu
