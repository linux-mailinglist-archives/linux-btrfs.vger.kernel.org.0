Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D78365663C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Dec 2022 01:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiL0ASR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Dec 2022 19:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiL0ASP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Dec 2022 19:18:15 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1811026;
        Mon, 26 Dec 2022 16:18:13 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAfUe-1oyv3h3vgm-00B4PN; Tue, 27
 Dec 2022 01:18:10 +0100
Content-Type: multipart/mixed; boundary="------------CooeKSmLhBqAnaqWOsk1lsqA"
Message-ID: <24cd64b2-4536-372c-91af-b425d2f6efd4@gmx.com>
Date:   Tue, 27 Dec 2022 08:18:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [6.2][regression] after commit
 947a629988f191807d2d22ba63ae18259bb645c5 btrfs volume periodical forced
 switch to readonly after a lot of disk writes
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     wqu@suse.com, dsterba@suse.com,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
 <f68699c3-ec5e-d8e8-f101-6e9a7020ac81@gmx.com>
 <CABXGCsNrm3ddn3p_ECSRe+yQeoF3KojTFvy-CpXNzi9ADkbnvQ@mail.gmail.com>
 <18b5fa1e-7d1e-4560-c98b-d7ac5fc87c3a@gmx.com>
 <CABXGCsM5y6m=pLX7tyE-RB1yuHEgZh3fxDu5ESfTRxEnW+djZA@mail.gmail.com>
 <0036622d-53f7-eaba-f720-6dd9bdca28ad@gmx.com>
 <CABXGCsMMYmCT_Hz=wfKWDy4OQJ2KyBO3rNAFC1YCAthziWm+Lg@mail.gmail.com>
 <41734bdb-2df0-6596-01b6-76a7dfd05d64@gmx.com>
 <CABXGCsM6GOzr+wL9BEk7mD5xLNgsKE5KUBADD8r783V6-FwXdg@mail.gmail.com>
 <e9f4d768-d91b-b5cc-dbe6-041a81833cf3@gmx.com>
 <CABXGCsPK6ZZ4=5qathvjqSJNde6MYhA0uvh6zAMznT9Yj3xk2g@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CABXGCsPK6ZZ4=5qathvjqSJNde6MYhA0uvh6zAMznT9Yj3xk2g@mail.gmail.com>
X-Provags-ID: V03:K1:SQCyw761wz8lI5asbaq1mrSkz/1FrR6Yo2GKUoli+B6rmX0Rjqo
 HvLOQMCc6v6xtKp59bD9t63v1ukZ564/pN4IgWxbzjjazzqSrQgzdXZb0rcAz6PYKJeYYlR
 TsYY9TZFjZQXSWiRLuYPO4frWPDLvawRdRqye2rKU2eHvRwoFfp2cfGhljYWewv3q4EQNVr
 n9vIfGG+x5FW1A+QlPK3w==
UI-OutboundReport: notjunk:1;M01:P0:jJRJytjx7VY=;QgfUTgYBoS14CK6z7c3CLPVqH2L
 Q7QDvbAZJh0yUjw47bzH97h/j5AYa4gI9qioJYc8Y4e1UiOzBDJbrc0zKn+inu8OGSEJXJ+mQ
 gqEcye/nk0RpjPjEiil0phq/PHP41IRl8Hri6OJGAB4rzAyq1UheQkPbyzy34xCvlDHDFaVva
 OCdqtFRjAEjuh2t6tAI4XK5IsOJmAr2j6vssaS5aWCuPk6+5eee9H/GqFthnjKXqb9iA85UQA
 cHaXjw8SQhOJqEyUqPs0w8gQP9BlOCaKZLsBxT3iuEK1NGjPD595DNWlSkYPmGCmzjVjLrPIK
 5qPj0kJmYStG2/ZsB1LC6mjGh+phQ3+NHP5Bepw8hl2g/wa8U8FjhTFWsqAz7Bn+vCx5EwUKz
 O8x/OggC5ThTpObi3X7TN3bsC+W3kvCKhzbQDhPvjgEkybiOoYvesNXvecAELrqxhsReYpEcE
 IgcnBNLGbNPMIVxRbXSkcYf2y4hbrTqaYqFiElA60vhT189VbEqIlYiWCd/IY8nOv58Kk6+m9
 a6acO7NFvhYLE/HCJok7+EgywbJWtXKsK32Zxy8YmpvJQSeEiN/Kdxal6Cb0ndslCP2D7jrqK
 Yweixe1GRaLLWBPgt7j9izHmVoCs+nvZ7iXC7VcTP0xSyK/8QSAjc+nfSP2IdEBo7Esmnw6Iz
 mubmcavLbfucUirdabyeigIM0i/N+bBUp14iDXmiygaqJ6S/mzlOCNsfTwOOyJZ1WjBzUsavB
 w6O9QurzqSEUTgweRdUkDCPdBYjWwmkYL4EA8JJXXPXbs9C0vmgYECE94ch7y4RfyPmFLf6W1
 Uv1ImEdLjRne3UDCHO6oBGjQXVAzumRbakvYl+W3dHScdy3jcUPcfB8DKQGexaGjlj/hFugy5
 fC8ZmaJW6WQKrRzsORu4hW5j1hOov7Z3RL6WQa6LqTnP921wmYyxzRrUCZo3gExIOKILpIlV9
 DOnSl1g7tJY1j6jcVUALfburZlc=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------CooeKSmLhBqAnaqWOsk1lsqA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2022/12/27 07:52, Mikhail Gavrilov wrote:
> On Tue, Dec 27, 2022 at 4:36 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>> Please be aware that, this newer version may cause extra kernel
>> warnings, if it found any uninitialized btrfs_tree_parent_check
>> structure at submit time.
>>
>> But there are completely valid cases we can do that, thus it may cause
>> much larger dmesg output, and you should not rely on the kernel warning
>> to determine if the bug is triggered.
>>
> 
> The kernel failed to built with v2 patch.
> 
> Here list of compilatore error messages:
> fs/btrfs/disk-io.c: In function ‘btrfs_submit_metadata_bio’:
> fs/btrfs/disk-io.c:5413:2: error: unterminated argument list invoking
> macro "WARN_ON"
>   5413 | }
>        |  ^
>    CC      net/ipv4/icmp.o
> fs/btrfs/disk-io.c:851:17: error: ‘WARN_ON’ undeclared (first use in
> this function)
>    851 |                 WARN_ON(!memcmp(&check, &bbio->parent_check,
>        |                 ^~~~~~~
> fs/btrfs/disk-io.c:851:17: note: each undeclared identifier is
> reported only once for each function it appears in
> fs/btrfs/disk-io.c:851:24: error: expected ‘;’ at end of input
>    851 |                 WARN_ON(!memcmp(&check, &bbio->parent_check,
>        |                        ^
>        |                        ;
> ......
> fs/btrfs/disk-io.c:851:17: error: expected declaration or statement at
> end of input
>    851 |                 WARN_ON(!memcmp(&check, &bbio->parent_check,
>        |                 ^~~~~~~
> fs/btrfs/disk-io.c:851:17: error: expected declaration or statement at
> end of input
> fs/btrfs/disk-io.c:845:22: warning: unused variable ‘ret’ [-Wunused-variable]
>    845 |         blk_status_t ret;
>        |                      ^~~
> fs/btrfs/disk-io.c:844:40: warning: unused variable ‘check’ [-Wunused-variable]
>    844 |         struct btrfs_tree_parent_check check = {0};
>        |                                        ^~~~~
> fs/btrfs/disk-io.c:842:31: warning: unused variable ‘fs_info’
> [-Wunused-variable]
>    842 |         struct btrfs_fs_info *fs_info = inode->root->fs_info;
>        |                               ^~~~~~~
>    HDRTEST usr/include/linux/loadpin.h
> fs/btrfs/disk-io.c: At top level:
> fs/btrfs/disk-io.c:63:13: warning: ‘btrfs_destroy_ordered_extents’
> declared ‘static’ but never defined [-Wunused-function]
>     63 | static void btrfs_destroy_ordered_extents(struct btrfs_root *root);
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/btrfs/disk-io.c:64:12: warning: ‘btrfs_destroy_delayed_refs’
> declared ‘static’ but never defined [-Wunused-function]
>     64 | static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
>        |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/btrfs/disk-io.c:66:13: warning: ‘btrfs_destroy_delalloc_inodes’
> declared ‘static’ but never defined [-Wunused-function]
>     66 | static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root);
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/btrfs/disk-io.c:67:12: warning: ‘btrfs_destroy_marked_extents’
> declared ‘static’ but never defined [-Wunused-function]
>     67 | static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
>        |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/btrfs/disk-io.c:70:12: warning: ‘btrfs_destroy_pinned_extent’
> declared ‘static’ but never defined [-Wunused-function]
>     70 | static int btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
>        |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/btrfs/disk-io.c:72:12: warning: ‘btrfs_cleanup_transaction’
> declared ‘static’ but never defined [-Wunused-function]
>     72 | static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info);
>        |            ^~~~~~~~~~~~~~~~~~~~~~~~~
> fs/btrfs/disk-io.c:73:13: warning: ‘btrfs_error_commit_super’ declared
> ‘static’ but never defined [-Wunused-function]
>     73 | static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info);
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~
> fs/btrfs/disk-io.c:828:13: warning: ‘should_async_write’ defined but
> not used [-Wunused-function]
>    828 | static bool should_async_write(struct btrfs_fs_info *fs_info,
>        |             ^~~~~~~~~~~~~~~~~~
> fs/btrfs/disk-io.c:161:13: warning: ‘btrfs_supported_super_csum’
> defined but not used [-Wunused-function]
>    161 | static bool btrfs_supported_super_csum(u16 csum_type)
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/btrfs/disk-io.c:130:12: warning: ‘verify_parent_transid’ defined
> but not used [-Wunused-function]
>    130 | static int verify_parent_transid(struct extent_io_tree *io_tree,
>        |            ^~~~~~~~~~~~~~~~~~~~~
> fs/btrfs/disk-io.c:75:13: warning: ‘btrfs_free_csum_hash’ defined but
> not used [-Wunused-function]
>     75 | static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
>        |             ^~~~~~~~~~~~~~~~~~~~
>    CC      kernel/notifier.o
> make[3]: *** [scripts/Makefile.build:252: fs/btrfs/disk-io.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> 
> 

My bad, missing a ")" in the WARN_ON() line.

Fixed with v3 patch.

Thanks,
Qu
--------------CooeKSmLhBqAnaqWOsk1lsqA
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-add-extra-debug-for-level-mismatch.patch"
Content-Disposition: attachment;
 filename="0001-btrfs-add-extra-debug-for-level-mismatch.patch"
Content-Transfer-Encoding: base64

RnJvbSA2ZTgyMDlhNzNlMWRkNjllYTFjMGYwYjA4NjVlNDFmNzZkYTE0OTc2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8NmU4MjA5YTczZTFkZDY5ZWExYzBmMGIw
ODY1ZTQxZjc2ZGExNDk3Ni4xNjcyMTAwMjI4LmdpdC53cXVAc3VzZS5jb20+CkZyb206IFF1
IFdlbnJ1byA8d3F1QHN1c2UuY29tPgpEYXRlOiBNb24sIDI2IERlYyAyMDIyIDE2OjQ0OjA4
ICswODAwClN1YmplY3Q6IFtQQVRDSCB2M10gYnRyZnM6IGFkZCBleHRyYSBkZWJ1ZyBmb3Ig
bGV2ZWwgbWlzbWF0Y2gKCkN1cnJlbnRseSBJIGFzc3VtZSB0aGVyZSBpcyBzb21lIHJhY2Ug
b3IgdW5pbml0aWFsaXplZCB2YWx1ZSBmb3IKY2hlY2s6OmxldmVsLgoKVGhlIGV4dHJhIG91
dHB1dCBhcmUgZm9yIHR3byBsb2NhdGlvbnM6CgotIHZhbGlkYXRlX2V4dGVudF9idWZmZXIo
KQogIE91dHB1dCB0aGUgZXJyb3IgbWVzc2FnZSBmb3IgcmVhZCBlcnJvciBhbmQgdGhlIG1l
bWJlcnMgb2YgY2hlY2suCgotIHJlYWRfZXh0ZW50X2J1ZmZlcl9wYWdlcygpCiAgVGhpcyB3
aWxsIGR1bXAgdGhlIHN0YWNrIGZvciB1cyB0byBjYXRjaCB0aGUgb2ZmZW5kZXIuCgpTaWdu
ZWQtb2ZmLWJ5OiBRdSBXZW5ydW8gPHdxdUBzdXNlLmNvbT4KLS0tCkNoYW5nZWxvZzoKdjI6
Ci0gRXh0cmEgc3VibWlzc2lvbiB0aW1lIG91dHB1dAogIFRoaXMgd291bGQgZ3JlYXRlbHkg
ZW5sYXJnZSB0aGUgZG1lc2cgc2l6ZQoKLSBFeHRyYSB3YXJuaW5nIHdoZW4gc3VibWl0dGlu
ZyBhIG1ldGFkYXRhIGJpbwogIElmIHdlIGhhdmUgYW4gdW5pbml0aWFsaXplZCBjaGVjayBz
dHJ1Y3R1cmUsIGRvIGEgd2FybmluZyBhbmQgc3RhY2sKICBkdW1wIHRvIHNob3cgdGhlIG9m
ZmVuZGluZyBjYWxsIHRyYWNlLgoKdjM6Ci0gRml4IGEgY29tcGlsaW5nIGVycm9yCi0tLQog
ZnMvYnRyZnMvZGlzay1pby5jICAgfCAxOSArKysrKysrKysrKysrKysrKy0tCiBmcy9idHJm
cy9leHRlbnRfaW8uYyB8IDEzICsrKysrKysrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMjkg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9idHJmcy9k
aXNrLWlvLmMgYi9mcy9idHJmcy9kaXNrLWlvLmMKaW5kZXggZjhiNTk1NWYwMDNmLi40OWIw
NzdhY2YzNTkgMTAwNjQ0Ci0tLSBhL2ZzL2J0cmZzL2Rpc2staW8uYworKysgYi9mcy9idHJm
cy9kaXNrLWlvLmMKQEAgLTUzMCw2ICs1MzAsMTAgQEAgc3RhdGljIGludCB2YWxpZGF0ZV9l
eHRlbnRfYnVmZmVyKHN0cnVjdCBleHRlbnRfYnVmZmVyICplYiwKIAl9CiAKIAlpZiAoZm91
bmRfbGV2ZWwgIT0gY2hlY2stPmxldmVsKSB7CisJCWJ0cmZzX2VycihlYi0+ZnNfaW5mbywK
KyJsZXZlbCB2ZXJpZnkgZmFpbGVkIG9uIGxvZ2ljYWwgJWxsdSBtaXJyb3IgJXUgd2FudGVk
ICV1IGZvdW5kICV1IiwKKwkJCSAgZWItPnN0YXJ0LCBlYi0+cmVhZF9taXJyb3IsIGNoZWNr
LT5sZXZlbCwKKwkJCSAgZm91bmRfbGV2ZWwpOwogCQlyZXQgPSAtRUlPOwogCQlnb3RvIG91
dDsKIAl9CkBAIC01ODEsMTMgKzU4NSwyMCBAQCBzdGF0aWMgaW50IHZhbGlkYXRlX2V4dGVu
dF9idWZmZXIoc3RydWN0IGV4dGVudF9idWZmZXIgKmViLAogCWlmIChmb3VuZF9sZXZlbCA+
IDAgJiYgYnRyZnNfY2hlY2tfbm9kZShlYikpCiAJCXJldCA9IC1FSU87CiAKK291dDoKIAlp
ZiAoIXJldCkKIAkJc2V0X2V4dGVudF9idWZmZXJfdXB0b2RhdGUoZWIpOwotCWVsc2UKKwll
bHNlIHsKIAkJYnRyZnNfZXJyKGZzX2luZm8sCiAJCSJyZWFkIHRpbWUgdHJlZSBibG9jayBj
b3JydXB0aW9uIGRldGVjdGVkIG9uIGxvZ2ljYWwgJWxsdSBtaXJyb3IgJXUiLAogCQkJICBl
Yi0+c3RhcnQsIGViLT5yZWFkX21pcnJvcik7Ci1vdXQ6CisJCWJ0cmZzX2VycihlYi0+ZnNf
aW5mbywKKyJjaGVjayBvd25lcl9yb290PSVsbHUgdHJhbnNpZD0lbGx1IGZpcnN0X2tleT0o
JWxsdSAldSAlbGx1KSBoYXNfZmlyc3Rfa2V5PSVkIGxldmVsPSV1IiwKKwkJCSAgY2hlY2st
Pm93bmVyX3Jvb3QsCisJCQkgIGNoZWNrLT50cmFuc2lkLCBjaGVjay0+Zmlyc3Rfa2V5Lm9i
amVjdGlkLAorCQkJICBjaGVjay0+Zmlyc3Rfa2V5LnR5cGUsIGNoZWNrLT5maXJzdF9rZXku
b2Zmc2V0LAorCQkJICBjaGVjay0+aGFzX2ZpcnN0X2tleSwgY2hlY2stPmxldmVsKTsKKwl9
CiAJcmV0dXJuIHJldDsKIH0KIApAQCAtNjUyLDYgKzY2Myw3IEBAIGludCBidHJmc192YWxp
ZGF0ZV9tZXRhZGF0YV9idWZmZXIoc3RydWN0IGJ0cmZzX2JpbyAqYmJpbywKIAlpbnQgcmVh
ZHNfZG9uZTsKIAogCUFTU0VSVChwYWdlLT5wcml2YXRlKTsKKwlXQVJOX09OKCFiYmlvLT5p
c19tZXRhZGF0YSk7CiAKIAlpZiAoYnRyZnNfc2IocGFnZS0+bWFwcGluZy0+aG9zdC0+aV9z
YiktPm5vZGVzaXplIDwgUEFHRV9TSVpFKQogCQlyZXR1cm4gdmFsaWRhdGVfc3VicGFnZV9i
dWZmZXIocGFnZSwgc3RhcnQsIGVuZCwgbWlycm9yLApAQCAtODMzLDEyICs4NDUsMTUgQEAg
dm9pZCBidHJmc19zdWJtaXRfbWV0YWRhdGFfYmlvKHN0cnVjdCBidHJmc19pbm9kZSAqaW5v
ZGUsIHN0cnVjdCBiaW8gKmJpbywgaW50IG0KIHsKIAlzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAq
ZnNfaW5mbyA9IGlub2RlLT5yb290LT5mc19pbmZvOwogCXN0cnVjdCBidHJmc19iaW8gKmJi
aW8gPSBidHJmc19iaW8oYmlvKTsKKwlzdHJ1Y3QgYnRyZnNfdHJlZV9wYXJlbnRfY2hlY2sg
Y2hlY2sgPSB7MH07CiAJYmxrX3N0YXR1c190IHJldDsKIAogCWJpby0+Ymlfb3BmIHw9IFJF
UV9NRVRBOwogCWJiaW8tPmlzX21ldGFkYXRhID0gMTsKIAogCWlmIChidHJmc19vcChiaW8p
ICE9IEJUUkZTX01BUF9XUklURSkgeworCQlXQVJOX09OKCFtZW1jbXAoJmNoZWNrLCAmYmJp
by0+cGFyZW50X2NoZWNrLAorCQkJc2l6ZW9mKHN0cnVjdCBidHJmc190cmVlX3BhcmVudF9j
aGVjaykpKTsKIAkJYnRyZnNfc3VibWl0X2Jpbyhmc19pbmZvLCBiaW8sIG1pcnJvcl9udW0p
OwogCQlyZXR1cm47CiAJfQpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvZXh0ZW50X2lvLmMgYi9m
cy9idHJmcy9leHRlbnRfaW8uYwppbmRleCA4M2RkM2FhNTk2NjMuLmM5NGViMDM2ZGRlNCAx
MDA2NDQKLS0tIGEvZnMvYnRyZnMvZXh0ZW50X2lvLmMKKysrIGIvZnMvYnRyZnMvZXh0ZW50
X2lvLmMKQEAgLTUwMDUsOCArNTAwNSwxOSBAQCBpbnQgcmVhZF9leHRlbnRfYnVmZmVyX3Bh
Z2VzKHN0cnVjdCBleHRlbnRfYnVmZmVyICplYiwgaW50IHdhaXQsIGludCBtaXJyb3JfbnVt
LAogCWZvciAoaSA9IDA7IGkgPCBudW1fcGFnZXM7IGkrKykgewogCQlwYWdlID0gZWItPnBh
Z2VzW2ldOwogCQl3YWl0X29uX3BhZ2VfbG9ja2VkKHBhZ2UpOwotCQlpZiAoIVBhZ2VVcHRv
ZGF0ZShwYWdlKSkKKwkJaWYgKCFQYWdlVXB0b2RhdGUocGFnZSkpIHsKIAkJCXJldCA9IC1F
SU87CisJCQlidHJmc19lcnIoZWItPmZzX2luZm8sCisicmVhZCBmYWlsZWQsIGJ5dGVucj0l
bGx1IGNoZWNrIG93bmVyX3Jvb3Q9JWxsdSB0cmFuc2lkPSVsbHUgaGFzX2ZpcnN0X2tleT0l
ZCBmaXJzdF9rZXk9KCVsbHUgJXUgJWxsdSkgbGV2ZWw9JXUiLAorCQkJCSAgZWItPnN0YXJ0
LAorCQkJCSAgY2hlY2stPm93bmVyX3Jvb3QsIGNoZWNrLT50cmFuc2lkLAorCQkJCSAgY2hl
Y2stPmhhc19maXJzdF9rZXksCisJCQkJICBjaGVjay0+Zmlyc3Rfa2V5Lm9iamVjdGlkLAor
CQkJCSAgY2hlY2stPmZpcnN0X2tleS50eXBlLAorCQkJCSAgY2hlY2stPmZpcnN0X2tleS5v
ZmZzZXQsCisJCQkJICBjaGVjay0+bGV2ZWwpOworCQkJZHVtcF9zdGFjaygpOworCQl9CiAJ
fQogCiAJcmV0dXJuIHJldDsKLS0gCjIuMzkuMAoK

--------------CooeKSmLhBqAnaqWOsk1lsqA--
