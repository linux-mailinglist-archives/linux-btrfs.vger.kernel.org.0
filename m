Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4883A4AB314
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Feb 2022 02:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243629AbiBGBVr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Feb 2022 20:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiBGBVq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 20:21:46 -0500
X-Greylist: delayed 309 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 17:21:44 PST
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F5EC061348
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Feb 2022 17:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644196903;
        bh=nInV3f8qUtBS7Jrf+xbOKGCtqwcKigegKRt2q0UmCXQ=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=e86ddBNifI/HmDkKdDdnILh0bjfgSWMMOy7AaqCkXaBOq518Vw5mLbeTXLAkw9q78
         uXBpiXYLJDVgKSYeXyJUEcYeMSWfsrTxL6gyKx1w8u5LmcgwV3n/PHi6RQVs5fJeoZ
         zGMgEb1YtpfgYgGpH0SkK9u5rTpXsqSFoj3SKdyw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYeMj-1nmNie1YOZ-00Viio; Mon, 07
 Feb 2022 02:16:32 +0100
Content-Type: multipart/mixed; boundary="------------VOw32L8jZBf20jMeA3Gd0JeJ"
Message-ID: <43e00a03-c853-56cf-9cf6-dfb4f1d4694c@gmx.com>
Date:   Mon, 7 Feb 2022 09:16:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Jean-Denis Girard <jd.girard@sysnux.pf>,
        linux-btrfs@vger.kernel.org
References: <KTVQ6R.R75CGDI04ULO2@gmail.com>
 <9409dc0c-e99d-cc61-757e-727bd54c6ffd@gmx.com>
 <88b6fe3e-8317-8070-cb27-0aee4dc72cfb@gmx.com>
 <SL2P216MB11112B447FB0400149D320C1AC2B9@SL2P216MB1111.KORP216.PROD.OUTLOOK.COM>
 <61ad0e42-b38a-6b5f-2944-8c78e1508f4a@gmx.com> <stp1bs$l94$1@ciao.gmane.io>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Still seeing high autodefrag IO with kernel 5.16.5
In-Reply-To: <stp1bs$l94$1@ciao.gmane.io>
X-Provags-ID: V03:K1:wh4UFAt1ASciLHeXblvj5/6haZZdlmQSETB0OL7on1JnGplfxbG
 vgyH0+nOb2s6UxILVzufRFzi2cbDhcnZ29UUNAJ6Jb3PLlLNNevKHpLkQJ5tufxG5Z8u9bf
 72ux++/pgGfz1zRRYia57gyinA1wP6HySekq6kFueismMc2z+pgkYJEzQUjcoGI0ujAaIOv
 o8IoxaB/Cc14nil++jN8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QMha8PXbVj4=:9wU2ZnGKMQillJxWk0efUL
 qDLjmBMKIqsefGcnIWFm1CYzYmcpSwnsFOiOLfRrPD4M3amyjBFSE/OUC6AJcklPxowO4cg7r
 FSpcjkzgvuhEpO/JWbhr93xgP/kgTvsjz6GD5FE1bkxcUpvLh5wCdAVCZlOBZf8TSzlKsQRba
 5Xpp/5NyB+fnVJdhvBIphIyfpTqdEOLTkMP5fSoBAE8B3MWHqgWGmgc2usmuUsHV/XzKdrnwy
 DK7xKUxk/3437YskWoGJ2c1TkTkm+eYw09XFYzJUnYFDRDhi2eRD8tnhHrdY9BOYx0huiN8C3
 F/IIQqtVDSzcf01xIYzqHU5Iyl0ICi2GaU45sXmbtEAzHot+yB1xSAxgXbZuxfWG1W/GxNLsz
 0/s1xeIMqtpBlwRA1m6cvOZYCvgvbb2obBZz/T0XSzDg16SJ9ZE2nheqqUvUboOqs1y2sDbVr
 +Pbuq1D48LGLGAnYQlgZVgmuUVnpE5/+om5O6Vh50giwYmQBUBzEOMmms0MsMgLhpbyicCoFg
 fuXW6rgQhq3XKKIeViqXzRV1OjSVw2/qpw5j0TZ/HQ5Mo9Id0Qzo7gQgjYXzKWeR0TiDLHR7I
 3RYQah9pKB+Jn8VX7kisPOYdsHgJYQBZZLMUU3m7wAiy5EzgvmZ3RNDEXk9iOoJzda9hnZKT0
 BTa+RwH+kmQ4C+peTiXBJSjv83Fb4Ibx56ZGuJqJOcTUyuRdO1SFmpIUThhCrAPbClKaHRa+E
 rK5EiaJhmVb9BhFYeBQ+7XBbd0JU8PDcXSZIo/jMGTT6UVaXB3Id1HoQPXWZsRo3cfbYwZ7Q8
 1JY6tXGZqIsrh1VhLpNh4qhrwVsOjayJJ+T3lnYNBCmZb/azAV4p9AM3je7uGo8+VJn0AqrV7
 GZfnOq2FEBGVTbtzz1Zjn7h6Cf4voUu+E/0YxT+v/DqUEsBYSCoC4S8GCFS4Tq64tSple2OdS
 ftRHc5ByQEFlucy4/7Ez3PIINXCMsPmc6aNnSNovfkCkUMP8Tb98OrueKd9fLFjvfEC1ODki+
 C6XTRWsDKzQWwES6nES5DhOQzJd1ABeoDhTltD/IyslLevvoAILgUqCg0YlZFoyHfoYQcwpgd
 86eYDDUjR0OUis=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------VOw32L8jZBf20jMeA3Gd0JeJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 2022/2/7 01:43, Jean-Denis Girard wrote:
> Hi list,
>
> I'm also experiencing high IO with autodefrag on 5.16.6 patched
> with: -
> https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D609387,
>
>
- https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D611509,
> - btrfs-defrag-bring-back-the-old-file-extent-search-behavior.diff.

OK, btrfs_search_forward() doesn't help in this case I guess.

>
> After about 24 hours uptime, btrfs-cleaner is most of the time at 90
> % CPU usage
>
> %CPU  %MEM     TIME+ COMMAND 77,6   0,0  29:03.25 btrfs-cleaner 19,1
> 0,0   3:40.22 kworker/u24:8-btrfs-endio-write 19,1   0,0   1:50.46
> kworker/u24:27-btrfs-endio-write 18,4   0,0   4:14.82
> kworker/u24:7-btrfs-endio-write 17,4   0,0   4:08.08
> kworker/u24:10-events_unbound 17,4   0,0   4:23.41
> kworker/u24:9-btrfs-delalloc 15,8   0,0   3:41.21
> kworker/u24:3-btrfs-endio-write 15,1   0,0   2:12.61
> kworker/u24:26-blkcg_punt_bio 14,8   0,0   3:40.13
> kworker/u24:18-btrfs-delalloc 12,8   0,0   3:55.70
> kworker/u24:20-btrfs-delalloc 12,5   0,0   4:01.79
> kworker/u24:1-btrfs-delalloc 12,2   0,0   4:04.63
> kworker/u24:22-btrfs-endio-write 11,5   0,0   1:11.90
> kworker/u24:11-btrfs-endio-write 11,2   0,0   1:25.96
> kworker/u24:0-blkcg_punt_bio 10,2   0,0   4:24.17
> kworker/u24:24+events_unbound ...
>
> Load average is 5,56, 6,88, 6,71 while just writing that mail.
>
> And iostat shows:
>
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle 1,5%    0,0%
> 26,8%    6,3%    0,0%   65,4%
>
> tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
> kB_dscd Device 33893,50         0,0k       172,2M        57,8M
> 0,0k       1,7G 577,7M nvme0n1 169,40         0,0k         1,2M
> 0,0k       0,0k      12,5M 0,0k sda 178,90         0,0k         1,3M
> 0,0k       0,0k      12,5M 0,0k sdb
>
> I hope that helps.

And what are the mount options?

 From the CPU usage, it looks like there are some infinite loop, but I
can't find out why by a quick glance.

And since there is no extra read, it looks like it's doing defrag again
and again on the same inode and range.


Mind to apply attached `debug.diff`?

Then you still need to provide `/sys/kernel/debug/tracing/trace`, which
can be very large and full of added debug info.
(This means this can slow down your system)

The example of my local test would result something like this in above
trace file:

# tracer: nop
#
# entries-in-buffer/entries-written: 11/11   #P:16
#
#                                _-----=3D> irqs-off/BH-disabled
#                               / _----=3D> need-resched
#                              | / _---=3D> hardirq/softirq
#                              || / _--=3D> preempt-depth
#                              ||| / _-=3D> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
    btrfs-cleaner-1770    [014] .....   961.534329: btrfs_defrag_file:
entry r/i=3D5/257 start=3D0 len=3D131072 newer=3D7 thres=3D262144
    btrfs-cleaner-1770    [014] .....   961.534333:
defrag_collect_targets: add target r/i=3D5/257 start=3D0 len=3D16384 em=3D=
0
len=3D16384 gen=3D7 newer=3D7
    btrfs-cleaner-1770    [014] .....   961.534335:
defrag_collect_targets: add target r/i=3D5/257 start=3D16384 len=3D16384
em=3D16384 len=3D16384 gen=3D7 newer=3D7
    btrfs-cleaner-1770    [014] .....   961.534336:
defrag_collect_targets: add target r/i=3D5/257 start=3D32768 len=3D16384
em=3D32768 len=3D16384 gen=3D7 newer=3D7
    btrfs-cleaner-1770    [014] .....   961.534337:
defrag_collect_targets: add target r/i=3D5/257 start=3D49152 len=3D16384
em=3D49152 len=3D16384 gen=3D7 newer=3D7
    btrfs-cleaner-1770    [014] .....   961.534564:
defrag_collect_targets: add target r/i=3D5/257 start=3D0 len=3D16384 em=3D=
0
len=3D16384 gen=3D7 newer=3D7
    btrfs-cleaner-1770    [014] .....   961.534567:
defrag_collect_targets: add target r/i=3D5/257 start=3D16384 len=3D16384
em=3D16384 len=3D16384 gen=3D7 newer=3D7
    btrfs-cleaner-1770    [014] .....   961.534568:
defrag_collect_targets: add target r/i=3D5/257 start=3D32768 len=3D16384
em=3D32768 len=3D16384 gen=3D7 newer=3D7
    btrfs-cleaner-1770    [014] .....   961.534569:
defrag_collect_targets: add target r/i=3D5/257 start=3D49152 len=3D16384
em=3D49152 len=3D16384 gen=3D7 newer=3D7
    btrfs-cleaner-1770    [014] .....   961.534580: btrfs_defrag_file:
defrag target r/i=3D5/257 start=3D0 len=3D65536
    btrfs-cleaner-1770    [014] .....   961.534681:
btrfs_run_defrag_inodes: defrag finish r/i=3D5/257 ret=3D0 defragged=3D16
last_scanned=3D131072 last_off=3D0 cycled=3D0

Thanks,
Qu


>
>
> Thanks,

--------------VOw32L8jZBf20jMeA3Gd0JeJ
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

--------------VOw32L8jZBf20jMeA3Gd0JeJ--
