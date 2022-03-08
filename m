Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50D94D2220
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 21:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350110AbiCHUE2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 15:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350074AbiCHUE1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 15:04:27 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0223BBCC
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 12:03:29 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id l12so105660ljh.12
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 12:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=czsRGOkOn3Lgpr63tuiW4SCDSW01owb7EuPhkTzECmM=;
        b=bOcSUSaffQIuHF2CSU04hVbpPCejg/SdphJ6c1+LuWKBJjlLZbbCI4HeWDmKQqotw6
         Z+FhPUs0dHXmbekhhf5T8yXt+lsbxU+tYj01K3m3MHIYZXN4QXKRxMhMJnW0d8+S2sd3
         3/4ljensKECXT+zaZ2BHQJbn0bZRqLGy0/n0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czsRGOkOn3Lgpr63tuiW4SCDSW01owb7EuPhkTzECmM=;
        b=4ar6uL5niftTlk6RjhBJAUnrPkkAjUAIa9DQTzKrkUNBTji8K3asmVPzlTALSvSlgw
         j7Tl+tktIJqBTSYUxt2XPcpIy3b5IqfAwSWSZmI/qw9ZbhDBsYAyE/qkYM9a4HdSzHih
         bSVEZviRkLsuYBXWqnNhS/99V82bpBQ6s16FqOXe5j2L07wF23ayPiOt63dL92EvoEaR
         XKLvRdDIqv6lHj+kP0Jf4vw3D7yfhk5+/JjksT2LJJF0M4xgICknSz+LP2xpKnrCBtEu
         VNHIMd1B/7+KlAdjIA4gNrxD8esZNCpOwIsRUVOX6A91uku7Wuid42TVga4vTZjT2Kdt
         Ecgw==
X-Gm-Message-State: AOAM531ihBePslU6goj49QG29rf94X4HBrpsnFnB8ZRGMAKbWGuMPyW4
        yZueTf3D6ia+UsVVFGMmUkSUR1HTNH+o2QXM9PY=
X-Google-Smtp-Source: ABdhPJyc0S+DZMspLSaIyRzxxYG+UDdH2oTrhBEf7u9fo3jfQRSw2VQYoLOUW4Ef+Q+eDHkNaLQdpw==
X-Received: by 2002:a05:651c:14f:b0:246:e2c:a985 with SMTP id c15-20020a05651c014f00b002460e2ca985mr11660704ljd.122.1646769807519;
        Tue, 08 Mar 2022 12:03:27 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id a15-20020ac2520f000000b00445bcfca45fsm3666427lfl.248.2022.03.08.12.03.25
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 12:03:25 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id w12so9868527lfr.9
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 12:03:25 -0800 (PST)
X-Received: by 2002:ac2:44a4:0:b0:445:8fc5:a12a with SMTP id
 c4-20020ac244a4000000b004458fc5a12amr11949016lfm.27.1646769804575; Tue, 08
 Mar 2022 12:03:24 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com> <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 12:03:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com>
Message-ID: <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     David Hildenbrand <david@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000003abc5505d9ba794e"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--0000000000003abc5505d9ba794e
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 8, 2022 at 11:27 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I think the fix for this all might be something like the attached
> (TOTALLY UNTESTED)!

Still entirely untested, but I wrote a commit message for it in the
hopes that this actually works and Andreas can verify that it fixes
the issue.

Same exact patch, it's just now in my local experimental tree as a commit.

                  Linus

--0000000000003abc5505d9ba794e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-mm-gup-make-fault_in_safe_writeable-use-fixup_user_f.patch"
Content-Disposition: attachment; 
	filename="0001-mm-gup-make-fault_in_safe_writeable-use-fixup_user_f.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l0ik6w7o0>
X-Attachment-Id: f_l0ik6w7o0

RnJvbSBkOGMyZTBhODEyNzRkNjdlZGZmZjM3NjljNGMzN2UzNjRiYThkNmY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFR1ZSwgOCBNYXIgMjAyMiAxMTo1NTo0OCAtMDgwMApTdWJqZWN0OiBb
UEFUQ0hdIG1tOiBndXA6IG1ha2UgZmF1bHRfaW5fc2FmZV93cml0ZWFibGUoKSB1c2UKIGZpeHVw
X3VzZXJfZmF1bHQoKQoKSW5zdGVkYWQgb2YgdXNpbmcgR1VQLCBtYWtlIGZhdWx0X2luX3NhZmVf
d3JpdGVhYmxlKCkgYWN0dWFsbHkgZm9yY2UgYQonaGFuZGxlX21tX2ZhdWx0KCknIHVzaW5nIHRo
ZSBzYW1lIGZpeHVwX3VzZXJfZmF1bHQoKSBtYWNoaW5lcnkgdGhhdApmdXRleGVzIGFscmVhZHkg
dXNlLgoKVXNpbmcgdGhlIEdVUCBtYWNoaW5lcnkgbWVhbnQgdGhhdCBmYXVsdF9pbl9zYWZlX3dy
aXRlYWJsZSgpIGRpZCBub3QgZG8KZXZlcnl0aGluZyB0aGF0IGEgcmVhbCBmYXVsdCB3b3VsZCBk
bywgcmFuZ2luZyBmcm9tIG5vdCBhdXRvLWV4cGFuZGluZwp0aGUgc3RhY2sgc2VnbWVudCwgdG8g
bm90IHVwZGF0aW5nIGFjY2Vzc2VkIG9yIGRpcnR5IGZsYWdzIGluIHRoZSBwYWdlCnRhYmxlcyAo
R1VQIHNldHMgdGhvc2UgZmxhZ3Mgb24gdGhlIHBhZ2VzIHRoZW1zZWx2ZXMpLgoKVGhlIGxhdHRl
ciBjYXVzZXMgcHJvYmxlbXMgb24gYXJjaGl0ZWN0dXJlcyAobGlrZSBzMzkwKSB0aGF0IGRvIGFj
Y2Vzc2VkCmJpdCBoYW5kbGluZyBpbiBzb2Z0d2FyZSwgd2hpY2ggbWVhbnQgdGhhdCBmYXVsdF9p
bl9zYWZlX3dyaXRlYWJsZSgpCmRpZG4ndCBhY3R1YWxseSBkbyBhbGwgdGhlIGZhdWx0IGhhbmRs
aW5nIGl0IG5lZWRlZCB0by4KClJlcG9ydGVkLWJ5OiBBbmRyZWFzIEdydWVuYmFjaGVyIDxhZ3J1
ZW5iYUByZWRoYXQuY29tPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FIYzZG
VTVuUCtuemlOR0cwSkFGMUZVeC1HVjdrS0Z2TTdhWnVVX1hEMl8xdjR2bnZnQG1haWwuZ21haWwu
Y29tLwpDYzogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYt
Ynk6IGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPgotLS0KIG1t
L2d1cC5jIHwgNDAgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL21tL2d1cC5jIGIvbW0vZ3VwLmMKaW5kZXggYTlkNGQ3MjRhZWY3Li45ZTA4NWU3YjljMjgg
MTAwNjQ0Ci0tLSBhL21tL2d1cC5jCisrKyBiL21tL2d1cC5jCkBAIC0xNzQ1LDQ0ICsxNzQ1LDI4
IEBAIEVYUE9SVF9TWU1CT0woZmF1bHRfaW5fd3JpdGVhYmxlKTsKIHNpemVfdCBmYXVsdF9pbl9z
YWZlX3dyaXRlYWJsZShjb25zdCBjaGFyIF9fdXNlciAqdWFkZHIsIHNpemVfdCBzaXplKQogewog
CXVuc2lnbmVkIGxvbmcgc3RhcnQgPSAodW5zaWduZWQgbG9uZyl1bnRhZ2dlZF9hZGRyKHVhZGRy
KTsKLQl1bnNpZ25lZCBsb25nIGVuZCwgbnN0YXJ0LCBuZW5kOworCXVuc2lnbmVkIGxvbmcgZW5k
LCBuc3RhcnQ7CiAJc3RydWN0IG1tX3N0cnVjdCAqbW0gPSBjdXJyZW50LT5tbTsKLQlzdHJ1Y3Qg
dm1fYXJlYV9zdHJ1Y3QgKnZtYSA9IE5VTEw7Ci0JaW50IGxvY2tlZCA9IDA7CisJY29uc3QgdW5z
aWduZWQgaW50IGZhdWx0X2ZsYWdzID0gRkFVTFRfRkxBR19XUklURSB8IEZBVUxUX0ZMQUdfS0lM
TEFCTEU7CisJY29uc3Qgc2l6ZV90IG1heF9zaXplID0gNCAqIFBBR0VfU0laRTsKIAogCW5zdGFy
dCA9IHN0YXJ0ICYgUEFHRV9NQVNLOwotCWVuZCA9IFBBR0VfQUxJR04oc3RhcnQgKyBzaXplKTsK
KwllbmQgPSBQQUdFX0FMSUdOKHN0YXJ0ICsgbWluKHNpemUsIG1heF9zaXplKSk7CiAJaWYgKGVu
ZCA8IG5zdGFydCkKIAkJZW5kID0gMDsKLQlmb3IgKDsgbnN0YXJ0ICE9IGVuZDsgbnN0YXJ0ID0g
bmVuZCkgewotCQl1bnNpZ25lZCBsb25nIG5yX3BhZ2VzOwotCQlsb25nIHJldDsKIAotCQlpZiAo
IWxvY2tlZCkgewotCQkJbG9ja2VkID0gMTsKLQkJCW1tYXBfcmVhZF9sb2NrKG1tKTsKLQkJCXZt
YSA9IGZpbmRfdm1hKG1tLCBuc3RhcnQpOwotCQl9IGVsc2UgaWYgKG5zdGFydCA+PSB2bWEtPnZt
X2VuZCkKLQkJCXZtYSA9IHZtYS0+dm1fbmV4dDsKLQkJaWYgKCF2bWEgfHwgdm1hLT52bV9zdGFy
dCA+PSBlbmQpCi0JCQlicmVhazsKLQkJbmVuZCA9IGVuZCA/IG1pbihlbmQsIHZtYS0+dm1fZW5k
KSA6IHZtYS0+dm1fZW5kOwotCQlpZiAodm1hLT52bV9mbGFncyAmIChWTV9JTyB8IFZNX1BGTk1B
UCkpCi0JCQljb250aW51ZTsKLQkJaWYgKG5zdGFydCA8IHZtYS0+dm1fc3RhcnQpCi0JCQluc3Rh
cnQgPSB2bWEtPnZtX3N0YXJ0OwotCQlucl9wYWdlcyA9IChuZW5kIC0gbnN0YXJ0KSAvIFBBR0Vf
U0laRTsKLQkJcmV0ID0gX19nZXRfdXNlcl9wYWdlc19sb2NrZWQobW0sIG5zdGFydCwgbnJfcGFn
ZXMsCi0JCQkJCSAgICAgIE5VTEwsIE5VTEwsICZsb2NrZWQsCi0JCQkJCSAgICAgIEZPTExfVE9V
Q0ggfCBGT0xMX1dSSVRFKTsKLQkJaWYgKHJldCA8PSAwKQorCW1tYXBfcmVhZF9sb2NrKG1tKTsK
Kwlmb3IgKDsgbnN0YXJ0ICE9IGVuZDsgbnN0YXJ0ICs9IFBBR0VfU0laRSkgeworCQlpZiAoZml4
dXBfdXNlcl9mYXVsdChtbSwgbnN0YXJ0LCBmYXVsdF9mbGFncywgTlVMTCkpCiAJCQlicmVhazsK
LQkJbmVuZCA9IG5zdGFydCArIHJldCAqIFBBR0VfU0laRTsKIAl9Ci0JaWYgKGxvY2tlZCkKLQkJ
bW1hcF9yZWFkX3VubG9jayhtbSk7CisJbW1hcF9yZWFkX3VubG9jayhtbSk7CisKKwkvKiBJZiB3
ZSBnb3QgYWxsIG9mIG91ciAodHJ1bmNhdGVkKSBmYXVsdC1pbiwgd2UgY2xhaW0gd2UgZ290IGl0
IGFsbCAqLwogCWlmIChuc3RhcnQgPT0gZW5kKQogCQlyZXR1cm4gMDsKKworCS8qIC4uIG90aGVy
d2lzZSB3ZSdsbCB1c2UgdGhlIG9yaWdpbmFsIHVudHJ1bmNhdGVkIHNpemUgKi8KIAlyZXR1cm4g
c2l6ZSAtIG1pbl90KHNpemVfdCwgbnN0YXJ0IC0gc3RhcnQsIHNpemUpOwogfQogRVhQT1JUX1NZ
TUJPTChmYXVsdF9pbl9zYWZlX3dyaXRlYWJsZSk7Ci0tIAoyLjM1LjEuMzU2LmdlNjYzMGY1N2Nm
LmRpcnR5Cgo=
--0000000000003abc5505d9ba794e--
