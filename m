Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825FD776D5C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 03:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjHJBGd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 21:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjHJBGc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 21:06:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30681982
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 18:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1691629589; x=1692234389; i=quwenruo.btrfs@gmx.com;
 bh=VG3IsO073KTRn8uwJ3Q4dBXwCcrVj4n2Xqm1VutcJpQ=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=DbOwVqAU77JQbQFFuDnUKf09mPYTtAm4bvZUi++YihkYkbW1msz+iScnIEnQppniUyc3XCX
 BkKlgCkY/7de0gQ0krnd+sjwIrH581DXz8dl6NbY4qTfcolKnMYpvrn3UVSt3PTpB32kBPU7V
 zR/0UR4H92elJtK+9ce3iE+DJRQf+9wIX5qJr1zu5LZkQ9GQT5wFHKMQlEt8UO4Qx2Q8sao4C
 bwDa3jg2MsEkNHGgtSN2eMGbYFrfTKZWLzyubAopv/1fYaVMLa9pNQ2gIMD4DwYxx+8ljwsUM
 ABwbYI2FZjVTGTSYa5soQ5krPj7kosIc4ZoIBusvXqwxw3LVJlmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVNB1-1qKs8h3hO3-00SS69; Thu, 10
 Aug 2023 03:06:29 +0200
Message-ID: <a52d535a-d2e7-48cf-a4b1-35d83e04027f@gmx.com>
Date:   Thu, 10 Aug 2023 09:06:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: tests/misc/058: reduce the space requirement
 and speed up the test
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <173e7faa9202a5d3438cd5bbdca765708f3bc729.1691477705.git.wqu@suse.com>
 <ZNOGCSts6w4tm9nI@twin.jikos.cz> <ZNOIAAevFOADA3Zi@twin.jikos.cz>
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
In-Reply-To: <ZNOIAAevFOADA3Zi@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xWknxaLertqq0BCa2g+juIRMh+xuac4WnQKgvlXRHpfaQzHKpEu
 tjCH/cpSczZ09LaHrgqAj3ghIK8z8lV9F33JVu/sP7cmHYUYcWkVC7aCNXFJfVEC+2iGQjj
 VPR2ldWPkmD0RIaLnnMSOnqiHgLXs9aQ1vTOqAz+KMXNe80dpDR39JDDRgKEB5JjBlP3a9l
 08nVBRctvr0pLRCWF5sXQ==
UI-OutboundReport: notjunk:1;M01:P0:dnlWlHVoUjM=;EOXIxQHROIpCCz0zGZ2KVUYp2mz
 kAVsX5Dki6PEy9tmZccsq1b8QtB4a02AwkzI8z9z2jpl+Xh1w66anbwpWaw0bJuDncOQ2FHf4
 erJ9MEJELbB4MBzjAnJhM3gBGQqBeIHh6v1OdU46aL8Kvp88sy9bhrXiCbrmxB0Ye592FUR74
 +3vi6igmUXnynIGFrrbo8kT4eCDglY68SQQkWG126CncNDVQI3emjXSwQMM+gRvChhOgJ5Glu
 ZytlcDXV2ws9uekjQCmnJ0ufInDfHdqhZohxufyurYVZBAzc9dgRPCiSJYb2rWnHysiNso7pn
 VasIhmvGvoWNxBdg7EBHMiU0tQc00YctQdPd2/CitQxXcWSOL6rkKWsSG1ygsDSW2uVpT47rJ
 05ZuIA5uqkNyQMGK6efEQ5wJwL5GLYeNUhgxNXbO+o6/op8vbWOA6W1AICpLcdHkSmRuw34//
 vxyCaFPMVeUHGXkWFWmagU8yulcWkClLUMHG/7unoMv0wutVC3p87krQOuQG1NBcMmeHazxcq
 9/YYfJBXqlItFtijvikGQRj43v/Qc1UEWg+MQjeaU+3UcoAMOcIbjTr4llbiJpWi41MdZcvK6
 UGQcAEJEsCQINQSe/DY6lUTL7Bs9wJIfoLuGQMwioI2wFlaD9hy0fSgGI4jrV7yhs1IzSOwIp
 E54kAuze8s+SlZHQKH6RJOBVFnbgvMdXs51lplC84q4o9xgUjsI+wV3qA4is7XNKhsGXdSX8p
 RcTgZOVXcpEz2op4cguIYgtxNwKa2+AZnhz8O4pPTSEb97KqgovqggyWgtwbJpW0yvo3vS9E6
 GOPYWfhbyQ0U9f8B6vCSVQOwRga74GIQQKZaxzuu9LgbWGjsOBqpkZdgs+TaSFV24O5lx99HF
 Qe3cjOLe2hT+wfn6RY7fEJs12b/JaZTRM+u7hoDOxlvonYq95OANj1+L+lfRA1AX2FPxJaY7Y
 S4CxaSN6BOEz8a8GW+6wdTacnKU=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/9 20:35, David Sterba wrote:
> On Wed, Aug 09, 2023 at 02:26:49PM +0200, David Sterba wrote:
>> On Tue, Aug 08, 2023 at 02:55:21PM +0800, Qu Wenruo wrote:
>>> [BUG]
>>> When I was testing misc/058, the fs still has around 7GiB free space,
>>> but during that test case, btrfs kernel module reports write failures
>>> and even git commands failed inside that fs.
>>>
>>> And obviously the test case failed.
>>>
>>> [CAUSE]
>>> It turns out that, the test case itself would require 6GiB (4 data
>>> disks) + 1.5GiB x 2 (the two replace target), thus it requires 9 GiB
>>> free space.
>>>
>>> And obviously my partition is not that large and failed.
>>
>> The file sizes were picked so the replace is not too fast, this again
>> depends on the system. Please add more space for tests.
>>
>>> [FIX]
>>> In fact, we really don't need that much space at all.
>>>
>>> Our objective is to test "btrfs device replace --enqueue" functionalit=
y,
>>> there is not much need to wait for 1 second, we can just do the enqueu=
e
>>> immediately.
>>
>> This depends on the system and the sleep might be needed if the first
>> command does not start the first replace. The test is not testing just
>> the --enqueue, but that two replaces can be enqueued on top each other.
>> So we need the first one to start.
>>
>>> So this patch would reduce the file size to a more sane (and rounded)
>>> 2GiB, and do the enqueue immediately.
>>
>> I'm not sure that the test would actually work as intended after the
>> changes. The sleeps and dependency on system is fragile but we don't
>> have anything better than to over allocate and provide enough time for
>> the other commands to catch up.
>
> The reduced test still reliably verifies the fix so I'll apply it.
> Thanks.

Despite the merge, I still want to discuss the principle behind the test
cases.

Unlike fstests, we don't really have strong requirement on the disk
sizes, thus most tests only go a 2GiB sparse file.

This leads to very loose disk size requirement, just like this case, we
can easily go 6GiB (more accurate 9GiB) without any warning or checks in
advance.

I believe the proper way to go in the future would be either:

- Add a proper size requirement check
   Just like xfstests

- Put more explicit recommends on the file sizes
   We can recommend something like doing IO for 4sec, and only sleep for
   1sec.
   But unfortunate this is not future proof, as modern PCIE5 drives can
   already go beyond 10GiB/s sequential writes.

Although for this particular case, I'm wondering if it's possible to do
multiple enqueue calls? E.g:

   btrfs replace start --enqueue 2 $replace_dev1
   btrfs replace start --enqueue 2 $replace_dev2
   btrfs replace start --enqueue 2 $replace_dev1

If that's possible, I'd say it's better than any of the existing method.

Thanks,
Qu
