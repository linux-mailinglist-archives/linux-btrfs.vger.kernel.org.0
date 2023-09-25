Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2597AD4AA
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 11:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjIYJkN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 05:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjIYJkL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 05:40:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE2EEE
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 02:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695634795; x=1696239595; i=quwenruo.btrfs@gmx.com;
 bh=m9n4H780wL1CCXdKKedA3AqeHm1/N2OtaOsVjF9pCGw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=eUaDn+9HWBB3SncfyCtZNoT26Pu28I5BSNAL7glaKTVb/O5K5J6hr7dj5BCiB12AtJNlMERsRQf
 Y2MJp0cAbhVrtyJFdq0ZLg9KLbfdINQ/lh+x1ZLgQIOqVxKUxmfvTz1xs7zVmVXYcsWIzfKvnHG5a
 +HM28z1BHInUx6KdiCImALVPgcrSz7i2ydeYVbsc4wO2iujpUTz/47UcxC5MWiz6Lw8ptTCIHqSPm
 pkLmfiBzCfHz9XWdHfRZubglcu+3sw2QxC+JOm8O3XXxxYyA9npTT3ZZtAXaNTKDunengpvDvUVYz
 0n6YKvM/XOgxIW1lbvwNhikmzUNPsJui5DvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.18.112.28] ([173.244.62.20]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MatRT-1rMWvJ22N1-00cURb; Mon, 25
 Sep 2023 11:39:55 +0200
Message-ID: <221d1149-2c45-479f-b30c-d2ed61bc7c21@gmx.com>
Date:   Mon, 25 Sep 2023 19:09:51 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix a race which can lead to unreported write
 failure
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <8bc4c2aaa8d32ad92838b3778a85660ba7c6bfa8.1695617943.git.wqu@suse.com>
 <ZRFLfTSMBXs+JTkc@infradead.org>
 <ff3e9fc1-3c22-4645-8442-b08212a6c67f@gmx.com>
 <ZRFQzT/Gro1OmnLI@infradead.org>
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
In-Reply-To: <ZRFQzT/Gro1OmnLI@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GjQl0EgDcV8tukNbNdlVj6flqavzjTvAu2bT4LVJtkw6jTA5Xr6
 wUI7yaBDNFfqbzu9gQ5Pig4bbnrRyVU5W0iXA3TfsJlnJJk8wywyAaiOBs64Nk+D8BGIE0I
 OFlhnSQCjGIrYIwL9tr8eh5/8CWImHysGcw7n8MBo6RA//mdkNObb1d6cosnzk0Bn+s6pTH
 Z1nPhcIezdqHQuhQDgPEw==
UI-OutboundReport: notjunk:1;M01:P0:K90Dq8A3fHM=;rkZq/UfuaGDM49QAqi+FLnJMktn
 pGe26osHDUBq66S53CrXCntMsUTvEDoAWj9X7Ip4/QuPdnmlSyvyuJUbmsawv+MDDcAk1eYKp
 DQ57eHMjuXJQq1wDtUJqjs9nUjB3/t93hyX7JUJBnTaKkLmmBmJWQ6y2ioIQi+BX/28oLbRE4
 DM5+6FfCOLsbRAowTA1z6rq9WkAW30zkTo2EBfBDvGtJDeFexWzuLrqban3daTZd/o88aSOls
 cDTonuXaPAOW3BpMXvpUoCJqCIbC0GbjeewXXZufcOc3yQy9GJ29vBzFFewPeQb83AVe9Whmc
 Xhw2TgUpiDHoeT0l38LyzDnkYNNzIFMJgBnW9ALwNYOn3yztV8Fa+tLXUowEuDSmb5WagHOrs
 9Grz/gqhq7h7CTXzp4SAyl5ti1KK8aI1CNIlahteEPz7L2ggv7ALThlB6fQ5Wn7fbGuKhcCKH
 tWkXbG1VWIPrYf3vlBbIYF7VVsxcL1TddyMX/TRJLrNQX7xPytmj91q+XCSmjy2cqNNIPCnea
 ZpRUhGma9xbjViBpBOSpzPlh1CkXtVGNKEc5IRR5nRHyKGI09lu+cnz2MkDf+3CsYrTSNbVoZ
 lCdOfqQITmcIYmNSVVU7ZNTOJfpEwf8SvRa+gqlfx3sTrzji+K1QpyG3RDdMLws1xnHh1yABQ
 bWM6O7LPGfwSS3kW42H7juNjwQ6mRsWzepRK89XfA3En1zqxhV1NW1tW6uQ8Aas01rHXP+sfe
 zBTzg87PdxhNK9uccmJAX+ss4FjvyqC3lC99xz84WrCkfCtniNB/L/RLC1AhC+psebREWpeYo
 KdzGbuGdXaaPdZbaEV0ZhAHcxhjr0e/K95/nge+J/Jbh93Yn1WS4Ef7m+ddTmcqblwwZbffdo
 kJq1EIHNm4H8xfZGCQFHsMxMCAFqjMP4+sQms3Om6Wt5jYBj2cpFvKoKWQkBWT9I3u59ezsS3
 4Mk0K3eQTLTBEMmlEAWbojAhQsk=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/25 18:50, Christoph Hellwig wrote:
> On Mon, Sep 25, 2023 at 06:47:50PM +0930, Qu Wenruo wrote:
>> Sorry, I couldn't find out a hard guarantee to make
>> btrfs_orig_write_end_io() to always be executed after
>> btrfs_clone_write_end_io().
>
> That is how bio_inc_remaining works.  For each call to it you need
> an additional bio_endio call to counter it before ->end_io is called.
>
> So no matter how fast orig_bio is executed by the underlying
> driver/hardware, btrfs_orig_write_end_io will only be called once
> both orig_bio itself and any clone has completed.

Oh, that's what I missed.

After checking bio_endio(), it's indeed call bio_remaining_done() to
check the chained ones, and only after that, the real bio would be called.

Thus even if the last mirror finishes first, it would only reduce
__bi_remaining, and exit, not really calling the btrfs_orig_write_end_io()=
.

If the last bio finished is a cloned one, it would call bio_endio() on
the orig_bio, thus trigger the real endio for it (aka,
btrfs_orig_write_end_io()).

Thanks for pointing this out,
Qu
