Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B557020DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 May 2023 02:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjEOAoj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 May 2023 20:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbjEOAog (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 May 2023 20:44:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F77B10FE
        for <linux-btrfs@vger.kernel.org>; Sun, 14 May 2023 17:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1684111464; i=quwenruo.btrfs@gmx.com;
        bh=6dKZXKn5amYiiT8b5nxK0fJIjfdNtFl7JRP9WEXKsEo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=QjC9eAATSD9yAlc0WlxB0qJTQPvF9XFozmWXguSRlAcwMhuDG0oup2ZuDQjOgmaic
         dZHyW1jPebAH/RklEe59o3sov8LdXRkAt7JeBe7Eu2RUE/bWKOM2OuV3g9BZLdepX1
         hfTg8ziIbO9LsYEgp56ubr1sGSxQUUMiYg2U1EEuX5dZJbVFdxB5tEFhVWFODh6go5
         Xr/iug9WESMtf7kFza75J665tPI36HsoKduexT1/hTceRhRSTuWcd7zJy9bvDBLlY9
         GQdDGVtZbOWZFm6+fksITfr7tqny0WbhmcYiaURq+eN0aEZqa6QmGK6QdxV7Zm8Vxp
         Q+dRnQ2Myj4AA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNsw4-1pnSDI0516-00OHvy; Mon, 15
 May 2023 02:44:24 +0200
Content-Type: multipart/mixed; boundary="------------IpXTepGyWbEvESAbdP09ZhkE"
Message-ID: <6330a912-8ef5-cc60-7766-ea73cb0d84af@gmx.com>
Date:   Mon, 15 May 2023 08:44:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: 6.1 Replacement warnings and papercuts
Content-Language: en-US
To:     Matt Corallo <blnxfsl@bluematt.me>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <4f31977d-9e32-ae10-64fd-039162874214@bluematt.me>
 <2a832a70-2665-eb9e-5b66-e4a3595567e9@bluematt.me>
 <62b9ea2c-c8a3-375f-ed21-d4a9d537f369@gmx.com>
 <2554e872-91b0-849d-5b24-ccb47498983a@bluematt.me>
 <5d869041-1d1c-3fb8-ea02-a3fb189e7ba1@bluematt.me>
 <342ed726-4713-be1f-63dc-f2106f5becc1@gmx.com>
 <fa6ebdfe-acf0-e21b-5492-9b373668cad0@bluematt.me>
 <82b49e3f-164d-a5b4-0d19-b412f40341b9@bluematt.me>
 <07f98d39-de57-f879-8235-fb8fe20c317a@gmx.com>
 <add4973a-4735-7b84-c227-8d5c5b5358e6@bluematt.me>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <add4973a-4735-7b84-c227-8d5c5b5358e6@bluematt.me>
X-Provags-ID: V03:K1:HaIxtqkyn1mPrkSJ4YgDjrXciXeVdzfg8Qux/mDfaRFRlOT7aTT
 F1UPhutSa4AFJNYSYDWSwgBJaaul5by/FC0WNBP3iMZEzO+LbSkAd5hbWMuiYGpGL7ubvos
 0TMH9WJ8pOTcXw8qQ6cOENH1woOsp68LikHSa9SKtx47d4bkoQVEMiYZ2owk17u8g1lmwtI
 Roa5txlpSYZrnwIOFEgwA==
UI-OutboundReport: notjunk:1;M01:P0:6FCyfRCW3Zk=;SV7R6Wf4pvJhGq/KJr268yY8LLk
 PbusRh0KdrqrLJ/x04gTSNvAxQN6VCebJd4CgbuuEgLdmEfISIYP0l9ZmGot8NMdoBkuNI+wR
 7+dsZgmLcrQlOTQhPJyS7ELP/QAnxo4QJI+mBd4+Re5l7tc4ZCTX/gfcDJbBxIKaBjS3mjF3P
 mTJbzG2o1lrXN178HaWeYhynq4IMkLoKdWd5btH7DDL1qOXOKgGsMdpFyM0OJAH6AXxV7ddkR
 YupQsUytFgV8Z1DSzSy2H1NT1T02O4et5KBZp/xN93+LLh7WbFykalQt44bpiUsYdIggHTx5l
 PUf/Ftf9ZgHxrpStT75vtbhRYlPGQc9vEpmqr05e3dVWjc6RDmnMWdebDYY7iBIpXOoDMnFWn
 PqgpMtV3Ss/TrMIS6U0jvrBGOiKmDrqcu+2pX32yJGDNsUTQkGGdg9i8rF1/U8C69ynilGZh+
 k/WzRWpl/+Ou4rN5y7vWaudzc05AnGDUCSRbb0k761r+9LJGdjcPGInjUuf0crK7A8yrGZPcf
 zrRNpkUsmxee17HSLxUNFJn04U0lWMSwtem+B4Gbvy2h+mYuDnXSVE6N5sYS759i8PoOT71yh
 CWq6W14Jg21VSexIc6g7TqKJ7CbdZzlaq1fVFoPGH3LwNDpiOneuvbdM87acX1AvqA4EhMCXB
 z2of7f4NZ5bpzaUWM/i3hialhAKpIbsbY3PGOLxs5UIbXJoqTsAe5S/7crQUlOcR+je9A3ul8
 fy1RcNIGcCkLjhT/vOdVvSBbu3iuT5jlAjM4bT8yQAYBw3NaI+7C4mTNVqvHzHseQyKXN7qQj
 +VLEASn8AYfgwnCaWAcRF4LQ27d7znBBi3pC0SeljArJyMo2w15BWXzm6GV77ZBTjOBuHp4hH
 7utqE2W4aqyoVt0Ht/LBksxDm2hMUJ3dUHAJ5AN9eMdmG7XN7bLWwp7fMeL6bm149LHdugnkC
 AsDy2wc1QyXfMvVFmk8kexy+Jqk=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------IpXTepGyWbEvESAbdP09ZhkE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 2023/5/15 06:21, Matt Corallo wrote:
>
>
> On 5/14/23 3:15=E2=80=AFPM, Qu Wenruo wrote:
>>
>>
>> On 2023/5/15 05:40, Matt Corallo wrote:
>> [...]
>>>
>>> After a further powerfailure and reboot this issue appeared again, wit=
h
>>> similar flood of dmesg of the same WARN_ON over and over and over agai=
n.
>>
>> Sorry for the late reply.
>>
>> The full 300+MiB dmesg proved its usefulness, the sdd is hitting
>> something wrong:
>>
>> Apr 30 06:12:12 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#235 FAILED Result=
:
>> hostbyte=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D7s
>> Apr 30 06:12:12 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#235 Sense Key :
>> Medium Error [current]
>> Apr 30 06:12:12 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#235 Add. Sense:
>> Unrecovered read error
>> Apr 30 06:12:12 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#235 CDB: Read(16)
>> 88 00 00 00 00 00 1a 20 44 00 00 00 04 00 00 00
>> Apr 30 06:12:43 BEASTv3 kernel: sd 0:0:3:0: attempting task
>> abort!scmd(0x000000007277df8f), outstanding for 30248 ms & timeout
>> 30000 ms
>> Apr 30 06:12:43 BEASTv3 kernel: sd 0:0:3:0: [sdd] tag#307 CDB: Write(16=
)
>> 8a 08 00 00 00 00 00 00 00 80 00 00 00 08 00 00
>> Apr 30 06:12:43 BEASTv3 kernel: sd 0:0:3:0: task abort: SUCCESS
>> scmd(0x000000007277df8f)
>> Apr 30 06:12:43 BEASTv3 kernel: sd 0:0:3:0: attempting task
>> abort!scmd(0x000000007d5b5b6f), outstanding for 37624 ms & timeout
>> 30000 ms
>>
>> Then it explained why the warning flooding, as it meets the condition t=
o
>> trigger the warning, a subpage bug where PageError and PageUpdate is no=
t
>> properly updated.
>>
>> I'll double check if Christoph's patch is the only thing left.
>
> Oops, that's a red herring, sorry. That is the drive that was failing
> during the replace, so presumably it continuing to fail shouldn't be
> cause for an error?
>
> More importantly, today's similar WARN_ON flood did not include any such
> line, and the full dmesg from the array being mounted until the WARN_ON
> flood is literally:
>
> May 14 21:25:05 BEASTv3 kernel: BTRFS warning (device dm-2): read-write
> for sector size 4096 with page size 65536 is experimental
> May 14 21:25:09 BEASTv3 kernel: BTRFS info (device dm-2): bdev
> /dev/mapper/bigraid49_crypt errs: wr 0, rd 0, flush 0, corrupt 0, gen 2
> May 14 21:27:15 BEASTv3 kernel: BTRFS info (device dm-2): start tree-log
> replay
> May 14 21:27:20 BEASTv3 kernel: BTRFS info (device dm-2): checking UUID
> tree
> -- Some stuff talking about NICs appearing for containers --
> May 14 21:34:52 BEASTv3 kernel: ------------[ cut here ]------------
> May 14 21:34:52 BEASTv3 kernel: WARNING: CPU: 36 PID: 1018 at
> fs/btrfs/extent_io.c:5301 assert_eb_page_uptodate+0x80/0x140 [btrfs]
>
> Note that the `gen 2` there is from at least a year ago and long
> predates any issues here.

Full debug mode kicked in.

Would you mind to apply the attached patch and let it trigger?

After the regular paper cut, there would be extra warning lines (no
btrfs prefix yet), so please attach the warning and the following two
lines for debug.

Thanks,
Qu

>
> Thanks,
> Matt

--------------IpXTepGyWbEvESAbdP09ZhkE
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-subpage-dump-extra-subpage-bitmaps-for-debug.patch"
Content-Disposition: attachment;
 filename*0="0001-btrfs-subpage-dump-extra-subpage-bitmaps-for-debug.patc";
 filename*1="h"
Content-Transfer-Encoding: base64

RnJvbSBiZDFlZTdjMjgyMDQ0YWNmMzIyYzUxOWQ3YWJmNzczMWFkMmQyNTk2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8YmQxZWU3YzI4MjA0NGFjZjMyMmM1MTlk
N2FiZjc3MzFhZDJkMjU5Ni4xNjg0MTExMzQ3LmdpdC53cXVAc3VzZS5jb20+CkZyb206IFF1
IFdlbnJ1byA8d3F1QHN1c2UuY29tPgpEYXRlOiBNb24sIDE1IE1heSAyMDIzIDA4OjQwOjU5
ICswODAwClN1YmplY3Q6IFtQQVRDSF0gYnRyZnM6IHN1YnBhZ2U6IGR1bXAgZXh0cmEgc3Vi
cGFnZSBiaXRtYXBzIGZvciBkZWJ1ZwoKVGhlcmUgaXMgYSBidWcgcmVwb3J0IHRoYXQgYXNz
ZXJ0X2ViX3BhZ2VfdXB0b2RhdGUoKSBnZXQgdHJpZ2dlcmVkIGZvcgpmcmVlIHNwYWNlIHRy
ZWUgbWV0YWRhdGEuCgpXaXRob3V0IHByb3BlciBkdW1wIGZvciB0aGUgc3VicGFnZSBiaXRt
YXBzIGl0J3MgbXVjaCBoYXJkZXIgdG8gZGVidWcuCgpUaHVzIHRoaXMgcGF0Y2ggd291bGQg
ZHVtcCBhbGwgdGhlIHN1YnBhZ2UgYml0bWFwcyB3aXRoIG5lZWRlZCBvZmZzZXRzCmFuZCBw
YWdlIGZsYWdzIHRvIGhlbHAgZGVidWdnaW5nLgoKU2lnbmVkLW9mZi1ieTogUXUgV2VucnVv
IDx3cXVAc3VzZS5jb20+Ci0tLQogZnMvYnRyZnMvZXh0ZW50X2lvLmMgfCAgMyArKy0KIGZz
L2J0cmZzL3N1YnBhZ2UuYyAgIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKwogZnMvYnRy
ZnMvc3VicGFnZS5oICAgfCAgMiArKwogMyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvZXh0ZW50X2lvLmMg
Yi9mcy9idHJmcy9leHRlbnRfaW8uYwppbmRleCBkOGJlY2YxY2RiYzAuLjEzYzQzMjkxZGUw
NCAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvZXh0ZW50X2lvLmMKKysrIGIvZnMvYnRyZnMvZXh0
ZW50X2lvLmMKQEAgLTQ1NzAsNyArNDU3MCw4IEBAIHN0YXRpYyB2b2lkIGFzc2VydF9lYl9w
YWdlX3VwdG9kYXRlKGNvbnN0IHN0cnVjdCBleHRlbnRfYnVmZmVyICplYiwKIAkJdXB0b2Rh
dGUgPSBidHJmc19zdWJwYWdlX3Rlc3RfdXB0b2RhdGUoZnNfaW5mbywgcGFnZSwKIAkJCQkJ
CSAgICAgICBlYi0+c3RhcnQsIGViLT5sZW4pOwogCQllcnJvciA9IGJ0cmZzX3N1YnBhZ2Vf
dGVzdF9lcnJvcihmc19pbmZvLCBwYWdlLCBlYi0+c3RhcnQsIGViLT5sZW4pOwotCQlXQVJO
X09OKCF1cHRvZGF0ZSAmJiAhZXJyb3IpOworCQlpZiAoV0FSTl9PTighdXB0b2RhdGUgJiYg
IWVycm9yKSkKKwkJCWJ0cmZzX3N1YnBhZ2VfZHVtcF9iaXRtYXAoZnNfaW5mbywgcGFnZSwg
ZWItPnN0YXJ0LCBlYi0+bGVuKTsKIAl9IGVsc2UgewogCQlXQVJOX09OKCFQYWdlVXB0b2Rh
dGUocGFnZSkgJiYgIVBhZ2VFcnJvcihwYWdlKSk7CiAJfQpkaWZmIC0tZ2l0IGEvZnMvYnRy
ZnMvc3VicGFnZS5jIGIvZnMvYnRyZnMvc3VicGFnZS5jCmluZGV4IDA0NTExN2NhMGRkYy4u
OGQ2ODg3M2NhN2Q3IDEwMDY0NAotLS0gYS9mcy9idHJmcy9zdWJwYWdlLmMKKysrIGIvZnMv
YnRyZnMvc3VicGFnZS5jCkBAIC03NDUsMyArNzQ1LDI1IEBAIHZvaWQgYnRyZnNfcGFnZV91
bmxvY2tfd3JpdGVyKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLCBzdHJ1Y3QgcGFn
ZSAqcGFnZSwKIAkvKiBIYXZlIHdyaXRlcnMsIHVzZSBwcm9wZXIgc3VicGFnZSBoZWxwZXIg
dG8gZW5kIGl0ICovCiAJYnRyZnNfcGFnZV9lbmRfd3JpdGVyX2xvY2soZnNfaW5mbywgcGFn
ZSwgc3RhcnQsIGxlbik7CiB9CisKK3ZvaWQgYnRyZnNfc3VicGFnZV9kdW1wX2JpdG1hcChz
dHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywKKwkJCSAgICAgICBzdHJ1Y3QgcGFnZSAq
cGFnZSwgdTY0IHN0YXJ0LCB1MzIgbGVuKQoreworCXN0cnVjdCBidHJmc19zdWJwYWdlX2lu
Zm8gKnN1YnBhZ2VfaW5mbyA9IGZzX2luZm8tPnN1YnBhZ2VfaW5mbzsKKwlzdHJ1Y3QgYnRy
ZnNfc3VicGFnZSAqc3VicGFnZTsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOworCisJQVNTRVJU
KFBhZ2VQcml2YXRlKHBhZ2UpICYmIHBhZ2UtPnByaXZhdGUpOworCUFTU0VSVChzdWJwYWdl
X2luZm8pOworCXN1YnBhZ2UgPSAoc3RydWN0IGJ0cmZzX3N1YnBhZ2UgKilwYWdlLT5wcml2
YXRlOworCisKKwlzcGluX2xvY2tfaXJxc2F2ZSgmc3VicGFnZS0+bG9jaywgZmxhZ3MpOwor
CXByX3dhcm4oInBhZ2U9JWxsdSB1cHRvZGF0ZT0lZCBlcnJvcj0lZCBkaXJ0eT0lZCBzdGFy
dD0lbGx1IGxlbj0ldSBiaXRtYXBzPSUqcGJsXG4iLAorCQlwYWdlX29mZnNldChwYWdlKSwg
UGFnZVVwdG9kYXRlKHBhZ2UpLCBQYWdlRXJyb3IocGFnZSksIFBhZ2VEaXJ0eShwYWdlKSwK
KwkJc3RhcnQsIGxlbiwgc3VicGFnZV9pbmZvLT50b3RhbF9ucl9iaXRzLCBzdWJwYWdlLT5i
aXRtYXBzKTsKKwlwcl93YXJuKCJzdWJwYWdlIG9mZnNldHM6IHVwdG9kYXRlPSV1IGVycm9y
PSV1IGRpcnR5PSV1IHdyaXRlYmFjaz0ldVxuIiwKKwkJc3VicGFnZV9pbmZvLT51cHRvZGF0
ZV9vZmZzZXQsIHN1YnBhZ2VfaW5mby0+ZXJyb3Jfb2Zmc2V0LAorCQlzdWJwYWdlX2luZm8t
PmRpcnR5X29mZnNldCwgc3VicGFnZV9pbmZvLT53cml0ZWJhY2tfb2Zmc2V0KTsKKwlzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZzdWJwYWdlLT5sb2NrLCBmbGFncyk7Cit9CmRpZmYgLS1n
aXQgYS9mcy9idHJmcy9zdWJwYWdlLmggYi9mcy9idHJmcy9zdWJwYWdlLmgKaW5kZXggMGU4
MGFkMzM2OTA0Li5jZmZjNTlkNGVhNzUgMTAwNjQ0Ci0tLSBhL2ZzL2J0cmZzL3N1YnBhZ2Uu
aAorKysgYi9mcy9idHJmcy9zdWJwYWdlLmgKQEAgLTE1NCw1ICsxNTQsNyBAQCB2b2lkIGJ0
cmZzX3BhZ2VfYXNzZXJ0X25vdF9kaXJ0eShjb25zdCBzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAq
ZnNfaW5mbywKIAkJCQkgc3RydWN0IHBhZ2UgKnBhZ2UpOwogdm9pZCBidHJmc19wYWdlX3Vu
bG9ja193cml0ZXIoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sIHN0cnVjdCBwYWdl
ICpwYWdlLAogCQkJICAgICAgdTY0IHN0YXJ0LCB1MzIgbGVuKTsKK3ZvaWQgYnRyZnNfc3Vi
cGFnZV9kdW1wX2JpdG1hcChzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywKKwkJCSAg
ICAgICBzdHJ1Y3QgcGFnZSAqcGFnZSwgdTY0IHN0YXJ0LCB1MzIgbGVuKTsKIAogI2VuZGlm
Ci0tIAoyLjQwLjEKCg==

--------------IpXTepGyWbEvESAbdP09ZhkE--
