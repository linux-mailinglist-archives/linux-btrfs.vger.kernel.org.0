Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7EF779B0A
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Aug 2023 01:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjHKXJS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 19:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjHKXJQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 19:09:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3183C1E
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 16:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1691795315; x=1692400115; i=quwenruo.btrfs@gmx.com;
 bh=90fPO1QlPytdiAL3/V9WU7V1eDqxQXsduQPpE14Ca50=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=UMyT/APtUO60Lq1Vv96vnPXOR3iJKYenw5CUQK8PzCE7aSVw+cYA3aSFsVnKnE1/duESskQ
 T0ZUZF/fxpmHGWIXEPIwmKPuUbN7vmQ2AVQO2ZhcjJ/UkK7EIDjosrSOuGAIoqq22IE2e7rqE
 781AVrZLXXrP595gvp2rcPLdCK7nJSSW4EpsOvuceRtRYPdqW5yMxpR/ju5yKDL68qHsPex2C
 Wh9jF1vkyS3e09RG13SdTqJcHqxzzp07JWZsiljPGhciJx1V0cZv8mqTB9Yy4eyRZO997pKLz
 ffbZEvqCKGgIAZgfo+r2mulJ2Eq/gY96wzs1FUDOONdegD8qSnAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrhQC-1pyVba34eC-00ngT8; Sat, 12
 Aug 2023 01:08:35 +0200
Message-ID: <40896c57-d318-4800-a06a-48f9cf809f4e@gmx.com>
Date:   Sat, 12 Aug 2023 07:08:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs: remove v0 extent handling
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <2c8a0319e27ae48e0c0a6cedfd412382a705780e.1691751710.git.wqu@suse.com>
 <20230811144334.GO2420@twin.jikos.cz>
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
In-Reply-To: <20230811144334.GO2420@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hXC0BlOAS7nCFRzJJf/bp4t7D9Yn1UD4kRCm+ATJJqoEuFNwUAu
 d3jUDi3LTSE590YtJO5w+//jhYyr/Duk2RfPFxBUuYq4PMJU0O1DlmT3i8V61SH8s0UXadk
 iZBelQHKFKZzPGStChhKzkCc2Bv9E/w01/ygI1Ta5IjHr9yahkGDes04V91R3DXRNDT29jz
 vE49fqYTXHIuITBxCt2jw==
UI-OutboundReport: notjunk:1;M01:P0:5eF8vjUHCfU=;0oUvMEF1B+h5Dmz8fOpu7UjQSIL
 qf66W666zvtvRhLaLdY5ISSo6UfXowD9BHosb1G7Fax3eVQk/qMDTGVIcQuAfjUxPH4VW4ZWy
 DypU6K44G/R86L6uQ2A6M0Yvy5i+psnlNWynAsYbdxzoIvLHKEUm+saH89zfI7i8A1yH7eKOA
 n1lRArfG8kYm4p7PpUzWNzw7//6XOXYe+jh86jXdDMDZMUvhVIkKZNnN6iqfGoXaCcfUnSKLo
 P7jNpmYGZHqvNLi19pa8GvlKuXE6Fbh2905KbkuHo0t/x9x0g/HDVCRZcLQwYZaNKOU1ExGBK
 6+poY8luEnD+MdTej5rBF4FE2NKqVsI2BYSgZ2wDrI20KMVzMKSkK1imductjBFmPqkvri0W9
 F59chcXQn+e+aIaVHy0yUoOJdGjkGJXALVZZwgZtPvioaJpZiCR6Z5BnOwBIlYfZLnSpT6uao
 h323JtW2EYtkB/2xGdP6tiuRWHLM6YMTCQnQuJVZJPQums9YrB8qCID1Bk0TKqxwJyG8psfxL
 qqWBCWV7rHBRb+jFSUqn1NBWtNfJGscwP4yZWZ4PdAQL0la99hZKfF9DjcO6FW3exF5tN7lh7
 4KVzl7P9xsyxci09oDrck8bqQIVvF8wMXp8OMAAa06aeMfiMu7uBAoTiTrg1NAYst0l597oQ1
 0AQUbqHMtzSlD8YrfWJa5qbifxfOHblXxO9Zv84ON5fBegbKgf17iTQ2j5ACuZEHLFaWYjosI
 ILkJNv1uwDuwgQeQYCGFS4DrEI1jMy5nfLEEzy256c/71oQ31FCMBmjuiGCzq6kfFCA5KhrL7
 TrSrfmWj0owiSF53cT2wqSk2eeVnGR99iZoWbIiogHWBsyGzIzUsnKc8s9gIG+OFmlEbuLvCv
 NQ1OHpMrRD9nIx9tK3YvDCSovmPyyip87kGlsFFWn6Ag2Sp3zKozwX/hi51tq7iRSgsYYVyaT
 FlZEd1ddx8nB89bhYb9EO2okK6Q=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/11 22:43, David Sterba wrote:
> On Fri, Aug 11, 2023 at 07:02:11PM +0800, Qu Wenruo wrote:
>> The v0 extent item has been deprecated for a long time, and we don't ha=
ve
>> any report from the community either.
>>
>> So it's time to remove the v0 extent specific error handling, and just
>> treat them as regular extent tree corruption.
>>
>> This patch would remove the btrfs_print_v0_err() helper, and enhance th=
e
>> involved error handling to treat them just as any extent tree
>> corruption.
>
> We added the helper in 2018, so it's about 5 years ago, without any
> reports so yeah let's remove it for good, thanks.
>
> There are still remaining references to BTRFS_EXTENT_REF_V0_KEY in the
> tracepoints and in ctree.h,

Tracepoints are what I missed, but I didn't hit any "_V0" or "_v0"
inside fs/btrfs/ directory.

> at least the tracepiont should be deleted
> but we may need to  keep the ctree.h defintion documented so we don't
> reuse the key number yet. I can fix that in the commit.

We need the definition for sure, but IIRC it's in uapi now.

Anyway thanks for the fix!
Qu
