Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425B0548D39
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 18:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354928AbiFMLqn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 07:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356407AbiFMLob (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 07:44:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A95B4706A;
        Mon, 13 Jun 2022 03:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E36760AEB;
        Mon, 13 Jun 2022 10:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CD0C34114;
        Mon, 13 Jun 2022 10:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655117442;
        bh=zI7Obfv9I65TgPrGJ0r7gD68/UPE4m+4TBoR4QX7pvw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XB04uMOYaJa5iQltYUyAMI3SXjcSLMyD0GCOdaPXgP6thDz8nApuWoTP7J1kRTMsW
         /NfENp3HMLw2DOV91w1h+0RIIc8S1x+x52F6WwbAhT/TP6zbyW1LtwAyM5YvymOv68
         Fx2yS0ffLNAqoV6ja7mEV90rVsevpILj93pLaEu3hqMsREd+08hwzZBAwhFTgYoEEN
         PO8UjBOKT5laEIQoepd78juUBoqify2LShCuHdCCKTVF8Wqo9XJgv15OwVPvGXQttv
         UzuRZbQ1/6n6VMNYGuOxfVictT8zZr1R6FIKeKV3KnPicAArEW5fFJZ5LAsUPdu21H
         h/BKdN9AEccpw==
Received: by mail-qk1-f179.google.com with SMTP id c144so3687070qkg.11;
        Mon, 13 Jun 2022 03:50:42 -0700 (PDT)
X-Gm-Message-State: AOAM531m9b+DF0gBAS3G5wjSaYDzWGrcZNWP8ecXhohfv5rZmizWrfXS
        3jSvaEBlcgRKTtKtQhLXZHQWIdMO+lVcvBaSP3A=
X-Google-Smtp-Source: ABdhPJwAwbZROoC0SYeViyXQyNH1xf573QHtCbpBXsuBKFM09uYLZPgd+dMH4VxPKOzl92C2bYLN5xhxavxuxDqiABY=
X-Received: by 2002:a05:620a:142a:b0:6a6:8a05:f862 with SMTP id
 k10-20020a05620a142a00b006a68a05f862mr36788042qkj.11.1655117441503; Mon, 13
 Jun 2022 03:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <bf924988687205627604f36cbd8ff13936e938ab.1654009356.git.fdmanana@suse.com>
 <20220608152303.GB31193@xsang-OptiPlex-9020> <20220609094652.GB3668047@falcondesktop>
 <20220610012659.GA6844@xsang-OptiPlex-9020> <20220612143646.GA35020@xsang-OptiPlex-9020>
In-Reply-To: <20220612143646.GA35020@xsang-OptiPlex-9020>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 13 Jun 2022 11:50:05 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6mD=i_xBJbYD2JsK5EuHHKirbU8-9jtDoDjMqK2jKsjQ@mail.gmail.com>
Message-ID: <CAL3q7H6mD=i_xBJbYD2JsK5EuHHKirbU8-9jtDoDjMqK2jKsjQ@mail.gmail.com>
Subject: Re: [btrfs] 62bd8124e2: WARNING:at_fs/btrfs/block-rsv.c:#btrfs_release_global_block_rsv[btrfs]
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, lkp@lists.01.org
Content-Type: multipart/mixed; boundary="00000000000029ed3d05e1520ffb"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--00000000000029ed3d05e1520ffb
Content-Type: text/plain; charset="UTF-8"

On Sun, Jun 12, 2022 at 3:37 PM Oliver Sang <oliver.sang@intel.com> wrote:
>
> hi, Filipe Manana,
>
> On Fri, Jun 10, 2022 at 09:26:59AM +0800, Oliver Sang wrote:
> > hi, Filipe Manana,
> >
> > On Thu, Jun 09, 2022 at 10:46:52AM +0100, Filipe Manana wrote:
> > >
> > > I am unable to reproduce that on a 12 cores box.
> > > I also don't see anything wrong that could lead to that by manual inspection.
> > >
> > > How easy is it for you to trigger it?
> >
> > we reproduced this upon 62bd8124e2 4 times out of 6 runs.
> > but since the other 2 runs crash early due to other issues (below (1)), we
> > cannot say they are clean.
> > at the same time, the 6 runs for parent are clean.
> >
> > 7e2bb5b3f3bca223 62bd8124e2f17910fcd89568e50
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :6           67%           4:6     dmesg.RIP:btrfs_release_global_block_rsv[btrfs]
> >            :6           67%           4:6     dmesg.WARNING:at_fs/btrfs/block-rsv.c:#btrfs_release_global_block_rsv[btrfs]
> >            :6           33%           2:6     dmesg.kernel_BUG_at_fs/xfs/xfs_message.c  <----- (1)
> >
> >
> > >
> > > Can you also run it with CONFIG_BTRFS_ASSERT=y set in the kernel config?
> >
> > got it, we will enable this config and rerun tests, for both this commit and
> > parent.
>
> we enabled CONFIG_BTRFS_ASSERT=y as attached config and rerun tests, still can
> reproduce the issue, like:
>
>
> 7e2bb5b3f3bca223 62bd8124e2f17910fcd89568e50
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :16          94%          15:16    dmesg.RIP:btrfs_release_global_block_rsv[btrfs]
>            :16          94%          15:16    dmesg.WARNING:at_fs/btrfs/block-rsv.c:#btrfs_release_global_block_rsv[btrfs]
>            :16           6%           1:16    dmesg.kernel_BUG_at_fs/xfs/xfs_message.c
>
>
> attached one dmesg FYI

Thanks for running the test again Oliver.
Running the fxmark test on my machines, I can't trigger anything.

May I ask you to run again the test but with the attached debug patch
on top of it?

Also, if possible, with ftrace enabled like this:

modprobe btrfs
echo 0 > /sys/kernel/debug/tracing/tracing_on
echo > /sys/kernel/debug/tracing/trace
echo $((1 << 24)) > /sys/kernel/debug/tracing/buffer_size_kb
echo nop > /sys/kernel/debug/tracing/current_tracer
echo 1 > /sys/kernel/tracing/events/btrfs/btrfs_space_reservation/enable

echo 1 > /sys/kernel/debug/tracing/tracing_on

<run the test>

echo 0 > /sys/kernel/debug/tracing/tracing_on

Then collect the trace to a file and send it over to me:

cat /sys/kernel/debug/tracing/trace | xz -9 > trace.txt.xz

And of course, the dmesg result as well.

Thanks!



>
> >

--00000000000029ed3d05e1520ffb
Content-Type: text/x-patch; charset="US-ASCII"; name="btrfs_debug.patch"
Content-Disposition: attachment; filename="btrfs_debug.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l4clu7qs0>
X-Attachment-Id: f_l4clu7qs0

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2Jsb2NrLXJzdi5jIGIvZnMvYnRyZnMvYmxvY2stcnN2LmMK
aW5kZXggYjNlZTQ5YjBiMWU4Li5mYWIwNjM4YjFmMWUgMTAwNjQ0Ci0tLSBhL2ZzL2J0cmZzL2Js
b2NrLXJzdi5jCisrKyBiL2ZzL2J0cmZzL2Jsb2NrLXJzdi5jCkBAIC0xMTQsNiArMTE0LDkgQEAg
c3RhdGljIHU2NCBibG9ja19yc3ZfcmVsZWFzZV9ieXRlcyhzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAq
ZnNfaW5mbywKIAkJbnVtX2J5dGVzID0gYmxvY2tfcnN2LT5zaXplOwogCQlxZ3JvdXBfdG9fcmVs
ZWFzZSA9IGJsb2NrX3Jzdi0+cWdyb3VwX3Jzdl9zaXplOwogCX0KKwlpZiAoV0FSTl9PTihudW1f
Ynl0ZXMgPiBibG9ja19yc3YtPnNpemUpKQorCQlidHJmc19lcnIoZnNfaW5mbywgImJsb2NrX3Jz
diByZWxlYXNlIHNpemU9JWxsdSByZXNlcnZlZD0lbGx1IHR5cGU9JWQgbnVtX2J5dGVzPSVsbHUi
LAorCQkJICBibG9ja19yc3YtPnNpemUsIGJsb2NrX3Jzdi0+cmVzZXJ2ZWQsIGJsb2NrX3Jzdi0+
dHlwZSwgbnVtX2J5dGVzKTsKIAlibG9ja19yc3YtPnNpemUgLT0gbnVtX2J5dGVzOwogCWlmIChi
bG9ja19yc3YtPnJlc2VydmVkID49IGJsb2NrX3Jzdi0+c2l6ZSkgewogCQludW1fYnl0ZXMgPSBi
bG9ja19yc3YtPnJlc2VydmVkIC0gYmxvY2tfcnN2LT5zaXplOwpAQCAtMzE2LDkgKzMxOSwxMiBA
QCB2b2lkIGJ0cmZzX2Jsb2NrX3Jzdl9hZGRfYnl0ZXMoc3RydWN0IGJ0cmZzX2Jsb2NrX3JzdiAq
YmxvY2tfcnN2LAogewogCXNwaW5fbG9jaygmYmxvY2tfcnN2LT5sb2NrKTsKIAlibG9ja19yc3Yt
PnJlc2VydmVkICs9IG51bV9ieXRlczsKLQlpZiAodXBkYXRlX3NpemUpCisJaWYgKHVwZGF0ZV9z
aXplKSB7CisJCWlmIChibG9ja19yc3YtPnNpemUgPT0gMCkKKwkJCXRyYWNlX3ByaW50aygiYmxv
Y2tfcnN2IHR5cGU9JWQgc2l6ZSBiZWNhbWUgbm9uLXplcm8gKCVsbHUpXG4iLAorCQkJCSAgICAg
YmxvY2tfcnN2LT50eXBlLCBudW1fYnl0ZXMpOwogCQlibG9ja19yc3YtPnNpemUgKz0gbnVtX2J5
dGVzOwotCWVsc2UgaWYgKGJsb2NrX3Jzdi0+cmVzZXJ2ZWQgPj0gYmxvY2tfcnN2LT5zaXplKQor
CX0gZWxzZSBpZiAoYmxvY2tfcnN2LT5yZXNlcnZlZCA+PSBibG9ja19yc3YtPnNpemUpCiAJCWJs
b2NrX3Jzdi0+ZnVsbCA9IDE7CiAJc3Bpbl91bmxvY2soJmJsb2NrX3Jzdi0+bG9jayk7CiB9CkBA
IC00NjAsMTggKzQ2NiwzMiBAQCB2b2lkIGJ0cmZzX2luaXRfZ2xvYmFsX2Jsb2NrX3JzdihzdHJ1
Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbykKIAlidHJmc191cGRhdGVfZ2xvYmFsX2Jsb2NrX3Jz
dihmc19pbmZvKTsKIH0KIAorc3RhdGljIHZvaWQgZHVtcF9ibG9ja19yc3Yoc3RydWN0IGJ0cmZz
X2ZzX2luZm8gKmZzX2luZm8sIHN0cnVjdCBidHJmc19ibG9ja19yc3YgKnJzdikKK3sKKwlidHJm
c19lcnIoZnNfaW5mbywgImJsb2NrX3JzdiB0eXBlPSVkIHNpemU9JWxsdSByZXNlcnZlZD0lbGx1
IiwKKwkJICByc3YtPnR5cGUsIHJzdi0+c2l6ZSwgcnN2LT5yZXNlcnZlZCk7Cit9CisKIHZvaWQg
YnRyZnNfcmVsZWFzZV9nbG9iYWxfYmxvY2tfcnN2KHN0cnVjdCBidHJmc19mc19pbmZvICpmc19p
bmZvKQogewogCWJ0cmZzX2Jsb2NrX3Jzdl9yZWxlYXNlKGZzX2luZm8sICZmc19pbmZvLT5nbG9i
YWxfYmxvY2tfcnN2LCAodTY0KS0xLAogCQkJCU5VTEwpOwotCVdBUk5fT04oZnNfaW5mby0+dHJh
bnNfYmxvY2tfcnN2LnNpemUgPiAwKTsKLQlXQVJOX09OKGZzX2luZm8tPnRyYW5zX2Jsb2NrX3Jz
di5yZXNlcnZlZCA+IDApOwotCVdBUk5fT04oZnNfaW5mby0+Y2h1bmtfYmxvY2tfcnN2LnNpemUg
PiAwKTsKLQlXQVJOX09OKGZzX2luZm8tPmNodW5rX2Jsb2NrX3Jzdi5yZXNlcnZlZCA+IDApOwot
CVdBUk5fT04oZnNfaW5mby0+ZGVsYXllZF9ibG9ja19yc3Yuc2l6ZSA+IDApOwotCVdBUk5fT04o
ZnNfaW5mby0+ZGVsYXllZF9ibG9ja19yc3YucmVzZXJ2ZWQgPiAwKTsKLQlXQVJOX09OKGZzX2lu
Zm8tPmRlbGF5ZWRfcmVmc19yc3YucmVzZXJ2ZWQgPiAwKTsKLQlXQVJOX09OKGZzX2luZm8tPmRl
bGF5ZWRfcmVmc19yc3Yuc2l6ZSA+IDApOworCWlmIChXQVJOX09OKGZzX2luZm8tPnRyYW5zX2Js
b2NrX3Jzdi5zaXplID4gMCkpCisJCWR1bXBfYmxvY2tfcnN2KGZzX2luZm8sICZmc19pbmZvLT50
cmFuc19ibG9ja19yc3YpOworCWlmIChXQVJOX09OKGZzX2luZm8tPnRyYW5zX2Jsb2NrX3Jzdi5y
ZXNlcnZlZCA+IDApKQorCQlkdW1wX2Jsb2NrX3Jzdihmc19pbmZvLCAmZnNfaW5mby0+dHJhbnNf
YmxvY2tfcnN2KTsKKwlpZiAoV0FSTl9PTihmc19pbmZvLT5jaHVua19ibG9ja19yc3Yuc2l6ZSA+
IDApKQorCQlkdW1wX2Jsb2NrX3Jzdihmc19pbmZvLCAmZnNfaW5mby0+Y2h1bmtfYmxvY2tfcnN2
KTsKKwlpZiAoV0FSTl9PTihmc19pbmZvLT5jaHVua19ibG9ja19yc3YucmVzZXJ2ZWQgPiAwKSkK
KwkJZHVtcF9ibG9ja19yc3YoZnNfaW5mbywgJmZzX2luZm8tPmNodW5rX2Jsb2NrX3Jzdik7CisJ
aWYgKFdBUk5fT04oZnNfaW5mby0+ZGVsYXllZF9ibG9ja19yc3Yuc2l6ZSA+IDApKQorCQlkdW1w
X2Jsb2NrX3Jzdihmc19pbmZvLCAmZnNfaW5mby0+ZGVsYXllZF9ibG9ja19yc3YpOworCWlmIChX
QVJOX09OKGZzX2luZm8tPmRlbGF5ZWRfYmxvY2tfcnN2LnJlc2VydmVkID4gMCkpCisJCWR1bXBf
YmxvY2tfcnN2KGZzX2luZm8sICZmc19pbmZvLT5kZWxheWVkX2Jsb2NrX3Jzdik7CisJaWYgKFdB
Uk5fT04oZnNfaW5mby0+ZGVsYXllZF9yZWZzX3Jzdi5yZXNlcnZlZCA+IDApKQorCQlkdW1wX2Js
b2NrX3Jzdihmc19pbmZvLCAmZnNfaW5mby0+ZGVsYXllZF9yZWZzX3Jzdik7CisJaWYgKFdBUk5f
T04oZnNfaW5mby0+ZGVsYXllZF9yZWZzX3Jzdi5zaXplID4gMCkpCisJCWR1bXBfYmxvY2tfcnN2
KGZzX2luZm8sICZmc19pbmZvLT5kZWxheWVkX3JlZnNfcnN2KTsKIH0KIAogc3RhdGljIHN0cnVj
dCBidHJmc19ibG9ja19yc3YgKmdldF9ibG9ja19yc3YoCmRpZmYgLS1naXQgYS9mcy9idHJmcy9k
ZWxheWVkLWlub2RlLmMgYi9mcy9idHJmcy9kZWxheWVkLWlub2RlLmMKaW5kZXggZTFlODU2NDM2
YWQ1Li42OThhZThhOTE0MTUgMTAwNjQ0Ci0tLSBhL2ZzL2J0cmZzL2RlbGF5ZWQtaW5vZGUuYwor
KysgYi9mcy9idHJmcy9kZWxheWVkLWlub2RlLmMKQEAgLTU3Miw2ICs1NzIsMTcgQEAgc3RhdGlj
IHZvaWQgYnRyZnNfZGVsYXllZF9pdGVtX3JlbGVhc2VfbWV0YWRhdGEoc3RydWN0IGJ0cmZzX3Jv
b3QgKnJvb3QsCiAJYnRyZnNfYmxvY2tfcnN2X3JlbGVhc2UoZnNfaW5mbywgcnN2LCBpdGVtLT5i
eXRlc19yZXNlcnZlZCwgTlVMTCk7CiB9CiAKK3N0YXRpYyB2b2lkIGJ0cmZzX2RlbGF5ZWRfaXRl
bV9yZWxlYXNlX2xlYXZlcyhzdHJ1Y3QgYnRyZnNfZGVsYXllZF9ub2RlICpub2RlLAorCQkJCQkg
ICAgICB1bnNpZ25lZCBpbnQgbnVtX2xlYXZlcykKK3sKKwlzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAq
ZnNfaW5mbyA9IG5vZGUtPnJvb3QtPmZzX2luZm87CisJY29uc3QgdTY0IGJ5dGVzID0gYnRyZnNf
Y2FsY19pbnNlcnRfbWV0YWRhdGFfc2l6ZShmc19pbmZvLCBudW1fbGVhdmVzKTsKKworCXRyYWNl
X2J0cmZzX3NwYWNlX3Jlc2VydmF0aW9uKGZzX2luZm8sICJkZWxheWVkX2l0ZW0iLCBub2RlLT5p
bm9kZV9pZCwKKwkJCQkgICAgICBieXRlcywgMCk7CisJYnRyZnNfYmxvY2tfcnN2X3JlbGVhc2Uo
ZnNfaW5mbywgJmZzX2luZm8tPmRlbGF5ZWRfYmxvY2tfcnN2LCBieXRlcywgTlVMTCk7Cit9CisK
IHN0YXRpYyBpbnQgYnRyZnNfZGVsYXllZF9pbm9kZV9yZXNlcnZlX21ldGFkYXRhKAogCQkJCQlz
dHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywKIAkJCQkJc3RydWN0IGJ0cmZzX3Jvb3Qg
KnJvb3QsCkBAIC03NjEsOSArNzcyLDcgQEAgc3RhdGljIGludCBidHJmc19pbnNlcnRfZGVsYXll
ZF9pdGVtKHN0cnVjdCBidHJmc190cmFuc19oYW5kbGUgKnRyYW5zLAogCSAqIG1ldGFkYXRhIHNw
YWNlIGZyb20gdGhlIGRlbGF5ZWQgYmxvY2sgcmVzZXJ2ZS4KIAkgKi8KIAlpZiAoIXRlc3RfYml0
KEJUUkZTX0ZTX0xPR19SRUNPVkVSSU5HLCAmZnNfaW5mby0+ZmxhZ3MpKQotCQlidHJmc19ibG9j
a19yc3ZfcmVsZWFzZShmc19pbmZvLCAmZnNfaW5mby0+ZGVsYXllZF9ibG9ja19yc3YsCi0JCQkJ
CWJ0cmZzX2NhbGNfaW5zZXJ0X21ldGFkYXRhX3NpemUoZnNfaW5mbywgMSksCi0JCQkJCU5VTEwp
OworCQlidHJmc19kZWxheWVkX2l0ZW1fcmVsZWFzZV9sZWF2ZXMobm9kZSwgMSk7CiAKIAlBU1NF
UlQobm9kZS0+aW5kZXhfaXRlbXNfc2l6ZSA+PSB0b3RhbF9zaXplKTsKIAlub2RlLT5pbmRleF9p
dGVtc19zaXplIC09IHRvdGFsX3NpemU7CkBAIC03ODUsNiArNzk0LDcgQEAgc3RhdGljIGludCBi
dHJmc19pbnNlcnRfZGVsYXllZF9pdGVtcyhzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFu
cywKIAkJbXV0ZXhfbG9jaygmbm9kZS0+bXV0ZXgpOwogCQljdXJyID0gX19idHJmc19maXJzdF9k
ZWxheWVkX2luc2VydGlvbl9pdGVtKG5vZGUpOwogCQlpZiAoIWN1cnIpIHsKKwkJCUFTU0VSVChu
b2RlLT5pbmRleF9pdGVtc19zaXplID09IDApOwogCQkJbXV0ZXhfdW5sb2NrKCZub2RlLT5tdXRl
eCk7CiAJCQlicmVhazsKIAkJfQpAQCAtMTM2NiwxMyArMTM3Niw4IEBAIHN0YXRpYyB1bnNpZ25l
ZCBpbnQgbnVtX2Rpcl9pbmRleF9sZWF2ZXMoY29uc3Qgc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZz
X2luZm8sCiAJCQkJCSB1MzIgaW5kZXhfaXRlbXNfc2l6ZSkKIHsKIAljb25zdCB1bnNpZ25lZCBp
bnQgbGVhZl9kYXRhX3NpemUgPSBCVFJGU19MRUFGX0RBVEFfU0laRShmc19pbmZvKTsKLQl1bnNp
Z25lZCBpbnQgcmVzdWx0OwogCi0JcmVzdWx0ID0gaW5kZXhfaXRlbXNfc2l6ZSAvIGxlYWZfZGF0
YV9zaXplOwotCWlmICgoaW5kZXhfaXRlbXNfc2l6ZSAlIGxlYWZfZGF0YV9zaXplKSAhPSAwKQot
CQlyZXN1bHQrKzsKLQotCXJldHVybiByZXN1bHQ7CisJcmV0dXJuIERJVl9ST1VORF9VUChpbmRl
eF9pdGVtc19zaXplLCBsZWFmX2RhdGFfc2l6ZSk7CiB9CiAKIC8qIFdpbGwgcmV0dXJuIDAgb3Ig
LUVOT01FTSAqLwpAQCAtMTQ0OSw2ICsxNDU0LDggQEAgaW50IGJ0cmZzX2luc2VydF9kZWxheWVk
X2Rpcl9pbmRleChzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywKIAkJICogdGhlIGNh
c2Ugd2hlcmUgd2UgaGFkIGEgdHJhbnNhY3Rpb24gc3RhcnQgYW5kIGV4Y2x1ZGVzIHRoZQogCQkg
KiB0cmFuc2FjdGlvbiBqb2luIGNhc2UgKHdoZW4gcmVwbGF5aW5nIGxvZyB0cmVlcykuCiAJCSAq
LworCQl0cmFjZV9idHJmc19zcGFjZV9yZXNlcnZhdGlvbihmc19pbmZvLCAidHJhbnNhY3Rpb24i
LAorCQkJCQkgICAgICB0cmFucy0+dHJhbnNpZCwgYnl0ZXMsIDApOwogCQlidHJmc19ibG9ja19y
c3ZfcmVsZWFzZShmc19pbmZvLCB0cmFucy0+YmxvY2tfcnN2LCBieXRlcywgTlVMTCk7CiAJCUFT
U0VSVCh0cmFucy0+Ynl0ZXNfcmVzZXJ2ZWQgPj0gYnl0ZXMpOwogCQl0cmFucy0+Ynl0ZXNfcmVz
ZXJ2ZWQgLT0gYnl0ZXM7CkBAIC0xNTA1LDEyICsxNTEyLDggQEAgc3RhdGljIGludCBidHJmc19k
ZWxldGVfZGVsYXllZF9pbnNlcnRpb25faXRlbShzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5m
bywKIAlBU1NFUlQoKGxlYXZlc19iZWZvcmUgLSBsZWF2ZXNfYWZ0ZXIpIDw9IDEpOwogCiAJaWYg
KGxlYXZlc19hZnRlciA8IGxlYXZlc19iZWZvcmUgJiYKLQkgICAgIXRlc3RfYml0KEJUUkZTX0ZT
X0xPR19SRUNPVkVSSU5HLCAmZnNfaW5mby0+ZmxhZ3MpKSB7Ci0JCWNvbnN0IHU2NCBieXRlcyA9
IGJ0cmZzX2NhbGNfaW5zZXJ0X21ldGFkYXRhX3NpemUoZnNfaW5mbywgMSk7Ci0KLQkJYnRyZnNf
YmxvY2tfcnN2X3JlbGVhc2UoZnNfaW5mbywgJmZzX2luZm8tPmRlbGF5ZWRfYmxvY2tfcnN2LAot
CQkJCQlieXRlcywgTlVMTCk7Ci0JfQorCSAgICAhdGVzdF9iaXQoQlRSRlNfRlNfTE9HX1JFQ09W
RVJJTkcsICZmc19pbmZvLT5mbGFncykpCisJCWJ0cmZzX2RlbGF5ZWRfaXRlbV9yZWxlYXNlX2xl
YXZlcyhub2RlLCAxKTsKIAogCWJ0cmZzX3JlbGVhc2VfZGVsYXllZF9pdGVtKGl0ZW0pOwogCW11
dGV4X3VubG9jaygmbm9kZS0+bXV0ZXgpOwpAQCAtMTkzNiwxNCArMTkzOSwxMCBAQCBzdGF0aWMg
dm9pZCBfX2J0cmZzX2tpbGxfZGVsYXllZF9ub2RlKHN0cnVjdCBidHJmc19kZWxheWVkX25vZGUg
KmRlbGF5ZWRfbm9kZSkKIAlpZiAoIXRlc3RfYml0KEJUUkZTX0ZTX0xPR19SRUNPVkVSSU5HLCAm
ZnNfaW5mby0+ZmxhZ3MpICYmCiAJICAgIGRlbGF5ZWRfbm9kZS0+aW5kZXhfaXRlbXNfc2l6ZSA+
IDApIHsKIAkJdW5zaWduZWQgaW50IG51bV9sZWF2ZXM7Ci0JCXU2NCBieXRlczsKIAogCQludW1f
bGVhdmVzID0gbnVtX2Rpcl9pbmRleF9sZWF2ZXMoZnNfaW5mbywKIAkJCQkJCSAgZGVsYXllZF9u
b2RlLT5pbmRleF9pdGVtc19zaXplKTsKLQkJYnl0ZXMgPSBidHJmc19jYWxjX2luc2VydF9tZXRh
ZGF0YV9zaXplKGZzX2luZm8sIG51bV9sZWF2ZXMpOwotCi0JCWJ0cmZzX2Jsb2NrX3Jzdl9yZWxl
YXNlKGZzX2luZm8sICZmc19pbmZvLT5kZWxheWVkX2Jsb2NrX3JzdiwKLQkJCQkJYnl0ZXMsIE5V
TEwpOworCQlidHJmc19kZWxheWVkX2l0ZW1fcmVsZWFzZV9sZWF2ZXMoZGVsYXllZF9ub2RlLCBu
dW1fbGVhdmVzKTsKIAl9CiAJZGVsYXllZF9ub2RlLT5pbmRleF9pdGVtc19zaXplID0gMDsKIAo=
--00000000000029ed3d05e1520ffb--
