Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6777979802A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 03:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbjIHB3b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 21:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjIHB3a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 21:29:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443291BD2
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 18:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1694136561; x=1694741361; i=quwenruo.btrfs@gmx.com;
 bh=PN204SaJtHg17ACHuGmq8xsL/XLzLtxKhG1IUHZcreI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=TbccNOOk49LZugODdS7KcMHuencpFX09FtSB+JmNEiPcZB6nm7afe6AIX3xEv3jhDdZuua7
 ZSsoN+wPD2fhvUxkYVZYNljgzfA6WdiJ++hfCmsRytKc+WZ2yRn5RaNlfvsw5X/Sfe2Y0Ehuf
 /fKLJ9S1tTtmdoklwqueBuHqe5/jX+D3eCHkrmZb7Wjay4B5LqfcOSljCxcn/iqvFiqmDyTre
 1Uq09Z0BT/JjElO4F2vKnplOpWasXS4owEM7fA485IG9DxUQnPyieuUhmmUvtQqwcqZJKZVo/
 eeHdRqf0xDKk2YuhsdhKSq7mtQd7C7BbAtjxPZFYtxNP1BOK0yjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Fjb-1qaq4V0x8x-006R40; Fri, 08
 Sep 2023 03:29:20 +0200
Message-ID: <e48b6243-212c-4eac-97db-5e89dd6e2c13@gmx.com>
Date:   Fri, 8 Sep 2023 09:29:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] btrfs: move extent_buffer::lock_owner to debug
 section
To:     dsterba@suse.cz
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1694126893.git.dsterba@suse.com>
 <3f96e9c3d06ed846b19b63cd9001cb0c66bd8a00.1694126893.git.dsterba@suse.com>
 <f941ac57-3daa-4246-bdeb-b12ab37ee26b@gmx.com>
 <20230908005605.GV3159@twin.jikos.cz>
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
In-Reply-To: <20230908005605.GV3159@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eo1jYT9Y4gL98SpRX+uMNyrHoAD/cGBb1ZDyyCTJs7iuJ/S4i24
 iv/HOrHgb9k3JpxMSL9CkR7c2LdEf9v9pU4dmFpnflgKLecjtbDoXzXDcKW1eXThJGXAOJD
 vuH6ziBe9sGcrfmD284x0SeSQ0BdkTyALG+h5p1R3oeALilXu6IKxyDFVO3SJpxxvIct7ay
 Abd0VB74Mxwkn5Ksl9XHw==
UI-OutboundReport: notjunk:1;M01:P0:l9DDoXnoJE4=;yNfBtevgLTc/2XCCF4wujwCtJ1W
 25CCu5rcN9S9IRD49JyhyiTpiF0VErqBXsCDtipan3KTkJ7t2EhTq2x96ZWw+9NyweKa+ldmk
 VrK+KAxuy0sh2c32j+kReQdpz3IqZs/OMm7A30NPdP5Q3OTlP+ff83zBNwvkErmBo/Eidv+lw
 KGoj+wP7o76RzM70bsvd+hjaA+JRwgcyOPNy3O93jK4bOQDTCe2cZ3zdTt+D+0873MdqQqznj
 uDEXlImfZJ28PyVjqcmbkFAv2T6gvC24olb8HB+iV3z6MSfvIBKNsBlXCOVI+CZZq7nSf5N41
 NrtNusCV0rXQyUo4rBjNmgf+w7KKSJ4PGmJor6eF0ScPTaRNLn0xbepzv+P5YHOp20cbXRa9i
 O5w07WQrnGHXfrXB0JgWCr0PuDLeO/f1jvV4eE2PFAbbucGknrRigdR6NsOa+APE7tpT6kS7N
 iFQDmpoMxh5d1oj0Wj5EtMguxkxO/l8OotQ9MlASP8LRrRJtbakLvpsOFiH+FimsW/VpnEGII
 vYqcicdDuUXS8x/e772sMOdY0NFIiwCGtcosic4na6HKBG78fiLaltNsJB02X7rb+/ORkubWf
 BOpCz7Bb8A68K2/b9O1KrCvp8loCYZ1fDhb97t72llXw5oeclU5zjRwmEBt2oMP9ZLl+tzvUN
 oIU0fpTBRZh1GIwgcU1rvzSY44r8YRtw9PrQwQS8aXPj6wvPhd8xdPpL0Kie+Wl2idqQQeSy4
 IHKcQ9Z0faKbR76M3PpusfR8pgdQ461yQNmeMyhMucDiWzFd88Rg2Jg71JoVJTchDqOrsFx0M
 FG11dVdFiym8NCG+EEhTN/55rynWfkINvY8aHh6+RrL7nHrUd/MmasSaIQtQxCVfxU0ThOACd
 oAKKSsyPwGoqZ7Z6gW02ZBhE+c+X7vq/t/xNbc3jIUXWtkDm5pAJS6JZbuT4NfNeYlZ+SBXyj
 ZZdDgh877/YD+sgGz0T5ZvHC8uU=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/8 08:56, David Sterba wrote:
> On Fri, Sep 08, 2023 at 08:11:43AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2023/9/8 07:09, David Sterba wrote:
>>> The lock_owner is used for a rare corruption case and we haven't seen
>>> any reports in years. Move it to the debugging section of eb.  To clos=
e
>>> the holes also move log_index so the final layout looks like:
>>
>> Just found some extra space we can squish out:
>
> Yeah I have a few more patches to reduce extent buffer size.
>
>>> struct extent_buffer {
>>>           u64                        start;                /*     0   =
  8 */
>>>           long unsigned int          len;                  /*     8   =
  8 */
>>
>> u32 is definitely enough.
>> (u16 is not enough for 64K nodesize, unfortunately)
>
> One idea is to store the bit shift and then calculate the length on each
> use but then we can simply not store the length in extent buffer at all
> because it's always fs_info->nodesize. In some functions it can be
> directly replaced by that, elsewhere it's needed to do
> eb->fs_info->nodesize. One more pointer dereference but from likely a
> cached memory, gaining 8 bytes.

Oh, that's way better. We used to use dummy extent buffer with fixed
size (4K) for sys chunk array read, but since commit e959d3c1df3a
("btrfs: use dummy extent buffer for super block sys chunk array read")
we just use nodesize and leave the extra space untouched.

But it may be better to dig deeper, as I'm not 100% sure if every
(including dummy ones) extent buffer goes nodesize.

>
>>
>>>           long unsigned int          bflags;               /*    16   =
  8 */
>>
>> For now we don't need 64bit for bflags, 32bit is enough, but
>> unfortunately that's what the existing test/set/clear_bit() requires...
>
> Indeed, and it's not just here, in the inode or some other structures
> taht store a few flags an u32 would suffice. I have a prototype to add
> atomic bit manipulations for a u32 type, but this requires manually
> written assembly so for now it's just x86. This could be useful outside
> of btrfs so I'd need to make it a proper API and get some feedback from
> wider audience.
>
>>>           struct btrfs_fs_info *     fs_info;              /*    24   =
  8 */
>>>           spinlock_t                 refs_lock;            /*    32   =
  4 */
>>>           atomic_t                   refs;                 /*    36   =
  4 */
>>>           int                        read_mirror;          /*    40   =
  4 */
>>
>> We don't really need int for read_mirror, but that would be another
>> patch(set) to change them.
>
> Yeah that's another potential space saved, I tried to track down all the
> use of mirror values but it's passed around to bios and back.

My current plan is to go s8, which still gives us 127 mirrors.
Which should be enough for RAID6 rebuilds.

Although we may need extra attention to prevent incorrect width
truncation/padding, as we're going to support minus number for
scrub_logical ioctl to grab P/Q stripes directly.

Thanks,
Qu
>
>>>           s8                         log_index;            /*    44   =
  1 */
>
> And log_index takes 3 values, this can be encoded into the flags, also a
> prototype but the code becomes ugly.
