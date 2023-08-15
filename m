Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E745477CB44
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Aug 2023 12:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbjHOKoL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Aug 2023 06:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbjHOKnp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Aug 2023 06:43:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6078199D
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 03:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692096216; x=1692701016; i=quwenruo.btrfs@gmx.com;
 bh=fBTNgzviqQ6H0bteaAuRzRL84T4tplEa/AEumHtDwEY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=gWVdWLRkLnUndj9gkDyGVkXqS9BokFUxNbyrZXrlrECgTZqvqHVIcS9E9QDovF7tIuyBhFP
 QLLwH02AF4IVzAY0XvsB3JaGAGwrhoFjWtbvbXMTGJqeiRibgjlsOr6WzyyvmAXWzoNYS3DAI
 Sjc76j6PdDMAywJ3Cr+NZ63AJORfMrNc+Ha5dOK9TTJ+QmZBlXmvAXVrOZLm6bG3Gc+gBHqPe
 AmY+Q0kcXNhvkyydWOzy+0b2EGy4FNaa6qQpokfqrv7ATUflQn39VK0Z1msAR4EbtJcp1agqs
 +wK+ZoTXHaFEartO+gGljwf+u72s0iGPXNmToIPK/jAOMarguBOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MplXp-1pzqh82mjd-00q6ts; Tue, 15
 Aug 2023 12:43:36 +0200
Message-ID: <7a1d68c1-5162-4063-a6eb-3fa993e49d1e@gmx.com>
Date:   Tue, 15 Aug 2023 18:43:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: scrub: avoid unnecessary extent tree search for
 striped profiles
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <88abe1beac119b714a62f5e622c673f418afede2.1692083778.git.wqu@suse.com>
 <431afc8c-683f-4767-b386-7527123084cc@wdc.com>
Content-Language: en-US
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
In-Reply-To: <431afc8c-683f-4767-b386-7527123084cc@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D/AqWCkAJOYoaj4MxH40MPFyqa8NypG6QXinEemWzAoeDxJjMmL
 282LaV8PAy+ovIyb0F8XZJc05JYXjpMF2AJg3337CwJw/U31doCSHxUoobcHKuhbQ6jjbv4
 FSSIElulC6l/GJszXqobOOue0H3Ph0gYyf715HDfidz1kLhpbuPpK+dDt0NXfkTPo2sXA2T
 DAOKQgfB2ZiuiPqbylZUg==
UI-OutboundReport: notjunk:1;M01:P0:IQOVU8p2Fng=;3Y+bwLH4oYwmVfnIUVQrNXlLybQ
 WJX+sgAbzEWrc2yzrF0marMhqaMNZoEUAB5iiUs9uaalNfTYTdgBFeHoTAvAdRJr6toWn3tTh
 JQpUC59+wKh7Qf/qjc1EEl/3juwzkbQeBlvEw27GZwZROoldvxOYye84IUBetxYuErazQ91gE
 GUr6PZnY/4/VGh31Sm1902ADN2qvFi3UYeAtxgs0zsgygBedmbDNQzwJwLkSq4CveWd0DNCs2
 VZuhrSR89xdt731z7RrQumsfE8HZLrMV76UOlxkYvdiVgKTu63BxPcApYwPEP4OpkijAjOOWg
 yFCO9v6rcrfwyfMEaKB8ytqeDJEXd7TskvjuuHcB0l8ZaEC5GZksDIxwnlMRys9QGyPtpx8J5
 f3r6Q4aWnFofK5DqH2y74lUDiefm2ejvA96YfME4Ow/T5Yr3ZoWzxsCPz5UWEg3szuskrwXWB
 ZFYEujAS3OaMcFfAwuR9+AOWIrc7J2jXQzj9HZOmOJtb4Y8ze41oIWm63F6hWSr2qtblcYfoc
 mx+WzMQnjzHKR1hJwbH7EQrAALf6Qt0/4+nho+TozNLjVXzcvl6N/eicaAHgISZTx84DS0xyv
 oBnOK5TySRofu7w2JPIeYghDnVpdLMQMgEzJI9SBz+lvPim2YXOVR3Yz2LJKRumVrLO2UhPmK
 4rl5dzxuO932PBrQPtEWxvysWrdXe+YFrLCPWrStK1wWrQSz9tyNjLc7pWdvbKpV4x4NhWKbk
 8aQhbCH+TZaqJKXMY4tbTcgyOnRhKbA/3Kfx+UaE7F7HkPxI3GU4dQ1Z6aAUd1qIr4CwXfleI
 YKxJ8r/+7xxN5lwydiNafSg+QZ+06F2U7Y3G2I2Vd7W2Fj931KVVRH7Emrm1f7l9P3gXBI+kf
 Y1Krzl+GYVOLm11Q1ktOg+fZAY5T5qxalA4vUA/FW4pMPJjYR6+WK5njwGykXravuU50rtThC
 WWxNzTQMNBL+8tQVo9Xv/d2zAY8=
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



On 2023/8/15 18:15, Johannes Thumshirn wrote:
> On 15.08.23 09:17, Qu Wenruo wrote:
>> +
>> +		/* No more extent item. all done. */
>> +		if (sctx->found_next >=3D bg->start + bg->length) {
>> +			sctx->stat.last_physical =3D orig_physical +
>> +				bg->length / (map->num_stripes / map->sub_stripes);
>> +			return 0;
>> +		}
>
> bg->length is a u64 so you'll need div_u64() here as well.
>
Yep, let me check if I have any variable at hand just like the
@physical_end one in the RAID56 realm.

Thanks,
Qu
