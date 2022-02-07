Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF8B4AB3E3
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Feb 2022 07:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiBGFtT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Feb 2022 00:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241068AbiBGDGF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 22:06:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1789C061A73
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Feb 2022 19:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644203156;
        bh=2lqrMNih89hI7zv6G8SWUE2j848em6Ra2VBTvlUC74w=;
        h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
        b=FLatRCAvJPw6l+t9kznDmUxzHWa013ga+ooSANTkNxPFmuKjMx1/Nrnkm0/5juaGb
         HlLdZLP//9pUhXCVdWbzTFf0N0cCs+HG5U5fPGVLCKwBxgo32izYf92njSYZI0xcyf
         X60TpXeiT04rHMz0DaYxpS1Zkek3BYkrnSg7voS0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6Db0-1nNW3P0tc8-006eZd; Mon, 07
 Feb 2022 04:05:55 +0100
Content-Type: multipart/mixed; boundary="------------OvPkSX4xZCRh0t88DXskpEr4"
Message-ID: <edb0fb57-7505-e552-cffc-b03a825c77e7@gmx.com>
Date:   Mon, 7 Feb 2022 11:05:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Still seeing high autodefrag IO with kernel 5.16.5
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Rylee Randall <ibrokemypie@outlook.com>,
        Benjamin Xiao <ben.r.xiao@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <KTVQ6R.R75CGDI04ULO2@gmail.com>
 <9409dc0c-e99d-cc61-757e-727bd54c6ffd@gmx.com>
 <88b6fe3e-8317-8070-cb27-0aee4dc72cfb@gmx.com>
 <SL2P216MB11112B447FB0400149D320C1AC2B9@SL2P216MB1111.KORP216.PROD.OUTLOOK.COM>
 <61ad0e42-b38a-6b5f-2944-8c78e1508f4a@gmx.com>
In-Reply-To: <61ad0e42-b38a-6b5f-2944-8c78e1508f4a@gmx.com>
X-Provags-ID: V03:K1:fskA8rBMsJN1JxleKl8XTRuU0D19tIYWQrC7k4FmeWyMJQhtklf
 scqbumNVJM2cqZNADGQmgYoh2RbwpaUnkh91FpD3N+IquVpHNt2E3rsMAZaE9FJaOkFox+4
 ngRrvDDBu0+OmHFJOS/GEKUT2rm6UZNGq9eRnfXtRKIC7Hw4p1Xcm78N83wK8iyARdILtHd
 RD/A/Si+EBeNFr6DQ4GFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zmn4XNBwic4=:oxxuGZB2OMypdma54Najjb
 zuLWKDn29iPH+kSl8YvAMDZiPBzAIBMeBuKQPWRV+m5BU2akX0/lsMKPdc2/lleTRAJoqzKdq
 Ck6GSZWplMGFjKuIGrK9nxZIfNwyPLXRhhsopFT3BcCQM3yI9kvDPZ8XdSyQEIQXmu/30xX6w
 iCLw9Sb5WXGyziWQYur6sE18KHLo9I/s1aE4Sokfa4QtcO2AZ/2ISt7jk1hMJ22IZ0k42r3VB
 zkpi4tniuSrMdVWjCVpoY+NSu7I8E8EtPGw6K7zrKvo59I/Wsgtx6ZxlPr6MdVkcHAGM1E83r
 btNF8RfsakEr8e0flJwl9+BWLBKWKbGdmO7UzNuUoPD349T1iNZf5vzRHwdS4Kqpb1Q5z1I9K
 ozDDkCH5a7kUsqNJWsrXU2CuyxVg2OBjM+svePGBkimpO7TPtIyJuYFiTvlk2fI4ZSc0w92eF
 MA5wPmhvDfPSO0Da1L0U9WHLlVWTygupP1htVOzrm9N1PitD9a0U5GVaxObfKS85PO7b0ME3+
 7GH0xYV2P9Oro8n1gAdVq51l7PfrEbuUTlnATLjlSfTAqREQO7plRdWKCOvz3Ig8CgU54ot0N
 1NheIJXTwUiHsFMmLIvT/kZr9JnHGCWTxAVxcSsEjRl4Wa1pIJ6utjQFpwSchDwk6swK4g6eC
 LV1zwJsHauHdirmXbMdDEoPmFc+QEIxsjdRGpIa/N/XjIIh4bmQoFBRg/vZ7PayBVbac/mLST
 xqxcqZ5C1HlprwCvn+4PRlyLG3zWRPZA5XkQxE9N/fpG2DAfQS+dr3hWNKC63IBZer35V62IT
 /udwfWyi2z1+7DXSaKLPVImRyQ5CBOh26JIDcgva2TdcuE+Yl6yopGim+r5jIdr8mI31hORlX
 rTYhUxzPnlprAtPVgfxylWMuucqoW+QJv+fC0IrbkmDgk+tZHNs6fNjuJpToHNsCOpovXfk3E
 GZkWxvtIQ3wVustAs5d5xVUa3yjkqQe9f0ZnqY0rkc06niwL0Ahk8990AfZmlu/xhxp7q0Sa3
 0aErpIkrT6VbjiJYy1gaBQtfZ4sm1IndThDhRW0a5nGuHvdBcf8zVZqu75xQN6WLOQh0G+czi
 sUlOsRbnjHvbZY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------OvPkSX4xZCRh0t88DXskpEr4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 2022/2/6 17:26, Qu Wenruo wrote:
>
>
> On 2022/2/6 15:51, Rylee Randall wrote:
>> I am experiencing the same issue on 5.16.7, near the end of a large
>> steam game download btrfs-cleaner sits at the top of iotop, and shut
>> downs take about ten minutes because of various btrfs hangs.
>>
>> I compiled 5.15.21 with the mentioned patch and tried to recreate the
>> issue and so far have been unable to. I seem to get far faster an dmore
>> consistent write speeds from steam, and rather than btrfs-cleaner being
>> the main source of io usage it is steam. btrfs-cleaner is far down the
>> list along with various other btrfs- tasks.
>
> Thanks for the report, this indeed looks like the bug in v5.15 that it
> doesn't defrag a lot of extents is not the root cause.
>
> Mind to re-check with the following branch?
>
> https://github.com/adam900710/linux/tree/autodefrag_fixes
>
> It has one extra patch to emulate the older behavior of not using
> btrfs_get_em(), which can cause quite some problem for autodefrag.


And if anyone is still experiencing the problem even with that branch,
there is a diff to do the ultimate debug (thus can slow down the system).

After applying this diff upon that branch, every auto defrag try will
have several lines added to `/sys/kernel/debug/tracing/trace`.
(Which can be pretty large).

And that trace file would greatly help us to locate which extent is
defragged again and again.

Thanks,
Qu
>
> Thanks,
> Qu
>
>>
>> On 4/2/22 12:54, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/2/4 09:17, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/2/4 04:05, Benjamin Xiao wrote:
>>>>> Hello all,
>>>>>
>>>>> Even after the defrag patches that landed in 5.16.5, I am still seei=
ng
>>>>> lots of cpu usage and disk writes to my SSD when autodefrag is
>>>>> enabled.
>>>>> I kinda expected slightly more IO during writes compared to 5.15, bu=
t
>>>>> what I am actually seeing is massive amounts of btrfs-cleaner i/o ev=
en
>>>>> when no programs are actively writing to the disk.
>>>>>
>>>>> I can reproduce it quite reliably on my 2TB Btrfs Steam library
>>>>> partition. In my case, I was downloading Strange Brigade, which is a
>>>>> roughly 25GB download and 33.65GB on disk. Somewhere during the
>>>>> download, iostat will start reporting disk writes around 300 MB/s,
>>>>> even
>>>>> though Steam itself reports disk usage of 40-45MB/s. After the
>>>>> download
>>>>> finishes and nothing else is being written to disk, I still see arou=
nd
>>>>> 90-150MB/s worth of disk writes. Checking in iotop, I can see btrfs
>>>>> cleaner and other btrfs processes writing a lot of data.
>>>>>
>>>>> I left it running for a while to see if it was just some maintenance
>>>>> tasks that Btrfs needed to do, but it just kept going. I tried to
>>>>> reboot, but it actually prevented me from properly rebooting. After
>>>>> systemd timed out, my system finally shutdown.
>>>>>
>>>>> Here are my mount options:
>>>>> rw,relatime,compress-force=3Dzstd:2,ssd,autodefrag,space_cache=3Dv2,=
subvolid=3D5,subvol=3D/
>>>>>
>>>>>
>>>>>
>>>>
>>>> Compression, I guess that's the reason.
>>>>
>>>> =C2=A0From the very beginning, btrfs defrag doesn't handle compressed=
 extent
>>>> well.
>>>>
>>>> Even if a compressed extent is already at its maximum capacity, btrfs
>>>> will still try to defrag it.
>>>>
>>>> I believe the behavior is masked by other problems in older kernels
>>>> thus
>>>> not that obvious.
>>>>
>>>> But after rework of defrag in v5.16, this behavior is more exposed.
>>>
>>> And if possible, please try this diff on v5.15.x, and see if v5.15 is
>>> really doing less IO than v5.16.x.
>>>
>>> The diff will solve a problem in the old code, where autodefrag is
>>> almost not working.
>>>
>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>> index cc61813213d8..f6f2468d4883 100644
>>> --- a/fs/btrfs/ioctl.c
>>> +++ b/fs/btrfs/ioctl.c
>>> @@ -1524,13 +1524,8 @@ int btrfs_defrag_file(struct inode *inode, stru=
ct
>>> file *file,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cont=
inue;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (!newer_than) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster =
=3D (PAGE_ALIGN(defrag_end) >>
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PAGE_SHIFT) - i;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster =
=3D min(cluster, max_cluster);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 } else {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster =
=3D max_cluster;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 cluster =3D (PAGE_ALIGN(defrag_end) >> PAGE_SHIFT) - i;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 cluster =3D min(cluster, max_cluster);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (i + cluster > ra_index) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ra_i=
ndex =3D max(i, ra_index);
>>>
>>>>
>>>> There are patches to address the compression related problem, but not
>>>> yet merged:
>>>>
>>>> https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D60938=
7
>>>>
>>>> Mind to test them to see if that's the case?
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>>
>>>>> I've disabled autodefrag again for now to save my SSD, but just want=
ed
>>>>> to say that there is still an issue. Have the defrag issues been ful=
ly
>>>>> fixed or are there more patches incoming despite what Reddit and
>>>>> Phoronix say? XD
>>>>>
>>>>> Thanks!
>>>>> Ben
>>>>>
>>>>>

--------------OvPkSX4xZCRh0t88DXskpEr4
Content-Type: text/x-patch; charset=UTF-8; name="debug.diff"
Content-Disposition: attachment; filename="debug.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2ZpbGUuYyBiL2ZzL2J0cmZzL2ZpbGUuYwppbmRleCBm
NWRlOGFiOTc4N2UuLmJlMmUyMGQxNjNlZiAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvZmlsZS5j
CisrKyBiL2ZzL2J0cmZzL2ZpbGUuYwpAQCAtMzA0LDYgKzMwNCwxMSBAQCBzdGF0aWMgaW50
IF9fYnRyZnNfcnVuX2RlZnJhZ19pbm9kZShzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5m
bywKIAlzYl9zdGFydF93cml0ZShmc19pbmZvLT5zYik7CiAJcmV0ID0gYnRyZnNfZGVmcmFn
X2ZpbGUoaW5vZGUsIE5VTEwsICZjdHJsKTsKIAlzYl9lbmRfd3JpdGUoZnNfaW5mby0+c2Ip
OworCXRyYWNlX3ByaW50aygiZGVmcmFnIGZpbmlzaCByL2k9JWxsZC8lbGx1IHJldD0lZCBk
ZWZyYWdnZWQ9JWxsdSBsYXN0X3NjYW5uZWQ9JWxsdSBsYXN0X29mZj0lbGx1IGN5Y2xlZD0l
ZFxuIiwKKwkJICAgICBCVFJGU19JKGlub2RlKS0+cm9vdC0+cm9vdF9rZXkub2JqZWN0aWQs
CisJCSAgICAgYnRyZnNfaW5vKEJUUkZTX0koaW5vZGUpKSwgcmV0LCBjdHJsLnNlY3RvcnNf
ZGVmcmFnZ2VkLAorCQkgICAgIGN0cmwubGFzdF9zY2FubmVkLAorCQkgICAgIGRlZnJhZy0+
bGFzdF9vZmZzZXQsIGRlZnJhZy0+Y3ljbGVkKTsKIAkvKgogCSAqIGlmIHdlIGZpbGxlZCB0
aGUgd2hvbGUgZGVmcmFnIGJhdGNoLCB0aGVyZQogCSAqIG11c3QgYmUgbW9yZSB3b3JrIHRv
IGRvLiAgUXVldWUgdGhpcyBkZWZyYWcKZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2lvY3RsLmMg
Yi9mcy9idHJmcy9pb2N0bC5jCmluZGV4IDEzM2UzZTJlMmU3OS4uYTA1MDFjODg5MjJiIDEw
MDY0NAotLS0gYS9mcy9idHJmcy9pb2N0bC5jCisrKyBiL2ZzL2J0cmZzL2lvY3RsLmMKQEAg
LTE0MjAsNiArMTQyMCwxMSBAQCBzdGF0aWMgaW50IGRlZnJhZ19jb2xsZWN0X3RhcmdldHMo
c3RydWN0IGJ0cmZzX2lub2RlICppbm9kZSwKIGFkZDoKIAkJbGFzdF9pc190YXJnZXQgPSB0
cnVlOwogCQlyYW5nZV9sZW4gPSBtaW4oZXh0ZW50X21hcF9lbmQoZW0pLCBzdGFydCArIGxl
bikgLSBjdXI7CisKKwkJdHJhY2VfcHJpbnRrKCJhZGQgdGFyZ2V0IHIvaT0lbGxkLyVsbHUg
c3RhcnQ9JWxsdSBsZW49JWxsdSBlbT0lbGx1IGxlbj0lbGx1IGdlbj0lbGxkIG5ld2VyPSVs
bHVcbiIsCisJCQlpbm9kZS0+cm9vdC0+cm9vdF9rZXkub2JqZWN0aWQsCisJCQlidHJmc19p
bm8oaW5vZGUpLCBjdXIsIHJhbmdlX2xlbiwgZW0tPnN0YXJ0LCBlbS0+bGVuLAorCQkJZW0t
PmdlbmVyYXRpb24sIGN0cmwtPm5ld2VyX3RoYW4pOwogCQkvKgogCQkgKiBUaGlzIG9uZSBp
cyBhIGdvb2QgdGFyZ2V0LCBjaGVjayBpZiBpdCBjYW4gYmUgbWVyZ2VkIGludG8KIAkJICog
bGFzdCByYW5nZSBvZiB0aGUgdGFyZ2V0IGxpc3QuCkBAIC0xNTIwLDYgKzE1MjUsOSBAQCBz
dGF0aWMgaW50IGRlZnJhZ19vbmVfbG9ja2VkX3RhcmdldChzdHJ1Y3QgYnRyZnNfaW5vZGUg
Kmlub2RlLAogCQkJIEVYVEVOVF9ERUZSQUcsIDAsIDAsIGNhY2hlZF9zdGF0ZSk7CiAJc2V0
X2V4dGVudF9kZWZyYWcoJmlub2RlLT5pb190cmVlLCBzdGFydCwgc3RhcnQgKyBsZW4gLSAx
LCBjYWNoZWRfc3RhdGUpOwogCisJdHJhY2VfcHJpbnRrKCJkZWZyYWcgdGFyZ2V0IHIvaT0l
bGxkLyVsbHUgc3RhcnQ9JWxsdSBsZW49JWxsdVxuIiwKKwkJCWlub2RlLT5yb290LT5yb290
X2tleS5vYmplY3RpZCwKKwkJCWJ0cmZzX2lubyhpbm9kZSksIHN0YXJ0LCBsZW4pOwogCS8q
IFVwZGF0ZSB0aGUgcGFnZSBzdGF0dXMgKi8KIAlmb3IgKGkgPSBzdGFydF9pbmRleCAtIGZp
cnN0X2luZGV4OyBpIDw9IGxhc3RfaW5kZXggLSBmaXJzdF9pbmRleDsgaSsrKSB7CiAJCUNs
ZWFyUGFnZUNoZWNrZWQocGFnZXNbaV0pOwpAQCAtMTc4Niw2ICsxNzk0LDEyIEBAIGludCBi
dHJmc19kZWZyYWdfZmlsZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZV9yYV9z
dGF0ZSAqcmEsCiAJaWYgKHN0YXJ0X2luZGV4IDwgaW5vZGUtPmlfbWFwcGluZy0+d3JpdGVi
YWNrX2luZGV4KQogCQlpbm9kZS0+aV9tYXBwaW5nLT53cml0ZWJhY2tfaW5kZXggPSBzdGFy
dF9pbmRleDsKIAorCXRyYWNlX3ByaW50aygiZW50cnkgci9pPSVsbGQvJWxsdSBzdGFydD0l
bGx1IGxlbj0lbGx1IG5ld2VyPSVsbHUgdGhyZXM9JXVcbiIsCisJCUJUUkZTX0koaW5vZGUp
LT5yb290LT5yb290X2tleS5vYmplY3RpZCwKKwkJYnRyZnNfaW5vKEJUUkZTX0koaW5vZGUp
KSwKKwkJY3RybC0+bGFzdF9zY2FubmVkLCBsYXN0X2J5dGUgKyAxIC0gY3RybC0+bGFzdF9z
Y2FubmVkLAorCQljdHJsLT5uZXdlcl90aGFuLCBjdHJsLT5leHRlbnRfdGhyZXNoKTsKKwog
CXdoaWxlIChjdHJsLT5sYXN0X3NjYW5uZWQgPCBsYXN0X2J5dGUpIHsKIAkJY29uc3QgdW5z
aWduZWQgbG9uZyBwcmV2X3NlY3RvcnNfZGVmcmFnZ2VkID0gY3RybC0+c2VjdG9yc19kZWZy
YWdnZWQ7CiAJCXU2NCBjbHVzdGVyX2VuZDsK

--------------OvPkSX4xZCRh0t88DXskpEr4--
