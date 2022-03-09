Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059B64D3AF2
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 21:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbiCIUUU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 15:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbiCIUUK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 15:20:10 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D359812F14D
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 12:19:10 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 3so5791514lfr.7
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 12:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ixsSzJyccfkLXZEYbJBe+Tg8HEZFA+58dxzkI0TlXwk=;
        b=Jij/llasGfimGoHd1XLy6zXbl5NbdV8ZlM1SFcbh7CybVLtODagLJPVQAVfLvID+KE
         Zqnwm85uO+wAG5FQAOg57bA2CGhLAkOVhShQcX0Oh8rBW43G7B8fBiY2jnYl0e1Y0tvw
         ZVhDsJOMuq1fNk3t5pSFJeWiorsDuxMlEfvAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ixsSzJyccfkLXZEYbJBe+Tg8HEZFA+58dxzkI0TlXwk=;
        b=oHsqTXnSEuZktY8WzXl5iuo2BXk6sl3LH9qRNXhQ26ogtXUpXaGjPcr5tdi4zsrAR1
         V6sn3eqJVygKEuG1BirFICrea0kBmdhLrsfyfIFNOeDiLC6HDs6Nj6GzOil+Og1DDAS2
         0Fcpcya3a08kNRCQRtYAXB1NfyGQNA95v2RsTVxF0zjnKAwcjVX/ryPj/Fvx47MSMYRm
         sU+oR1fOLHabr/7AVv4jWgqhSKdtrXMM1rTO5ezzViFA8ORa/V0nmE3KujIf+01Vjz9a
         9nem8Nf5F7htQlODDwPkRxzdsb9HlDHLvYvi83t21p0+RFYMk9CX2cG/24sSLQk+AIQI
         vyTw==
X-Gm-Message-State: AOAM533vNlifB2ctJgoRitcTHBmqluo450+3NP/oaiezYrRiMbTPWb1n
        E4DL51mfAIFcYy/voi0oOopAavvlg9v9eqkyxSQ=
X-Google-Smtp-Source: ABdhPJwXOxKVQsoKRlLhuI5gac/X8VvcnSIFfx2E8YfVZIQg5iHx80xCmMyylKiVFFmPCvJ1Yuw/TQ==
X-Received: by 2002:a05:6512:2613:b0:448:5164:689d with SMTP id bt19-20020a056512261300b004485164689dmr852792lfb.526.1646857148794;
        Wed, 09 Mar 2022 12:19:08 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id l18-20020a194952000000b00445bf2c3b83sm566196lfj.58.2022.03.09.12.19.04
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 12:19:06 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id u3so4926436ljd.0
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 12:19:04 -0800 (PST)
X-Received: by 2002:a2e:804b:0:b0:247:e81f:87e9 with SMTP id
 p11-20020a2e804b000000b00247e81f87e9mr831138ljg.176.1646857144051; Wed, 09
 Mar 2022 12:19:04 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com>
 <CAHc6FU6L8c9UCJF_qcqY=USK_CqyKnpDSJvrAGput=62h0djDw@mail.gmail.com>
 <CAHk-=whaoxuCPg4foD_4VBVr+LVgmW7qScjYFRppvHqnni0EMA@mail.gmail.com>
 <20220309184238.1583093-1-agruenba@redhat.com> <CAHk-=wixOLK1Xp-LKhqEWEh3SxGak_ziwR0_fi8uMzY5ZYBzbg@mail.gmail.com>
 <CAHc6FU6aqqYO4d5x3=73bxr+9yfL6CLJeGGzFwCZCy9wzApgwQ@mail.gmail.com>
In-Reply-To: <CAHc6FU6aqqYO4d5x3=73bxr+9yfL6CLJeGGzFwCZCy9wzApgwQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Mar 2022 12:18:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj4Av2gecvTfExCq-d2cXx0m7fdO0sG6JC1DxdCCDT7ig@mail.gmail.com>
Message-ID: <CAHk-=wj4Av2gecvTfExCq-d2cXx0m7fdO0sG6JC1DxdCCDT7ig@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000011bc1705d9cecf39"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--00000000000011bc1705d9cecf39
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 9, 2022 at 11:35 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> That's better, thanks.

Ok, can you give this one more test?

It has that simplified loop, but it also replaced the
FAULT_FLAG_KILLABLE with just passing in 'unlocked'.

I thought I didn't need to do that, but the "retry" loop inside
fixup_user_fault() will actually set that 'unlocked' thing even if the
caller doesn't care whether the mmap_sem was unlocked during the call,
so we have to pass in that pointer just to get that to work.

And we don't care if mmap_sem was dropped, because this loop doesn't
cache any vma information or anything like that, but we don't want to
get a NULL pointer oops just because fixup_user_fault() tries to
inform us about something we don't care about ;)

That incidentally gets us FAULT_FLAG_ALLOW_RETRY too, which is
probably a good thing anyway - it means that the mmap_sem will be
dropped if we wait for IO. Not likely a huge deal, but it's the
RightThing(tm) to do.

So this has some other changes there too, but on the whole the
function is now really quite simple. But it would be good to have one
final round of testing considering how many small details changed..

                      Linus

--00000000000011bc1705d9cecf39
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-mm-gup-make-fault_in_safe_writeable-use-fixup_user_f.patch"
Content-Disposition: attachment; 
	filename="0001-mm-gup-make-fault_in_safe_writeable-use-fixup_user_f.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l0k07iyo0>
X-Attachment-Id: f_l0k07iyo0

RnJvbSAyYTQzN2EwNWM0YzA2ZTIwODlmYTFhNzg5ZTk2MTAwZWEyMTM1ZjZhIE1vbiBTZXAgMTcg
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
aW5nIGl0IG5lZWRlZCB0by4KClJlcG9ydGVkLWFuZC10ZXN0ZWQtYnk6IEFuZHJlYXMgR3J1ZW5i
YWNoZXIgPGFncnVlbmJhQHJlZGhhdC5jb20+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC9DQUhjNkZVNW5QK256aU5HRzBKQUYxRlV4LUdWN2tLRnZNN2FadVVfWEQyXzF2NHZudmdA
bWFpbC5nbWFpbC5jb20vCkNjOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4K
U2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24u
b3JnPgotLS0KIG1tL2d1cC5jIHwgNTcgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCsp
LCAzOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9tbS9ndXAuYyBiL21tL2d1cC5jCmluZGV4
IGE5ZDRkNzI0YWVmNy4uN2JjMWJhOWNlNDQwIDEwMDY0NAotLS0gYS9tbS9ndXAuYworKysgYi9t
bS9ndXAuYwpAQCAtMTcyOSwxMSArMTcyOSwxMSBAQCBFWFBPUlRfU1lNQk9MKGZhdWx0X2luX3dy
aXRlYWJsZSk7CiAgKiBAdWFkZHI6IHN0YXJ0IG9mIGFkZHJlc3MgcmFuZ2UKICAqIEBzaXplOiBs
ZW5ndGggb2YgYWRkcmVzcyByYW5nZQogICoKLSAqIEZhdWx0cyBpbiBhbiBhZGRyZXNzIHJhbmdl
IHVzaW5nIGdldF91c2VyX3BhZ2VzLCBpLmUuLCB3aXRob3V0IHRyaWdnZXJpbmcKLSAqIGhhcmR3
YXJlIHBhZ2UgZmF1bHRzLiAgVGhpcyBpcyBwcmltYXJpbHkgdXNlZnVsIHdoZW4gd2UgYWxyZWFk
eSBrbm93IHRoYXQKLSAqIHNvbWUgb3IgYWxsIG9mIHRoZSBwYWdlcyBpbiB0aGUgYWRkcmVzcyBy
YW5nZSBhcmVuJ3QgaW4gbWVtb3J5LgorICogRmF1bHRzIGluIGFuIGFkZHJlc3MgcmFuZ2UgZm9y
IHdyaXRpbmcuICBUaGlzIGlzIHByaW1hcmlseSB1c2VmdWwgd2hlbiB3ZQorICogYWxyZWFkeSBr
bm93IHRoYXQgc29tZSBvciBhbGwgb2YgdGhlIHBhZ2VzIGluIHRoZSBhZGRyZXNzIHJhbmdlIGFy
ZW4ndCBpbgorICogbWVtb3J5LgogICoKLSAqIE90aGVyIHRoYW4gZmF1bHRfaW5fd3JpdGVhYmxl
KCksIHRoaXMgZnVuY3Rpb24gaXMgbm9uLWRlc3RydWN0aXZlLgorICogVW5saWtlIGZhdWx0X2lu
X3dyaXRlYWJsZSgpLCB0aGlzIGZ1bmN0aW9uIGlzIG5vbi1kZXN0cnVjdGl2ZS4KICAqCiAgKiBO
b3RlIHRoYXQgd2UgZG9uJ3QgcGluIG9yIG90aGVyd2lzZSBob2xkIHRoZSBwYWdlcyByZWZlcmVu
Y2VkIHRoYXQgd2UgZmF1bHQKICAqIGluLiAgVGhlcmUncyBubyBndWFyYW50ZWUgdGhhdCB0aGV5
J2xsIHN0YXkgaW4gbWVtb3J5IGZvciBhbnkgZHVyYXRpb24gb2YKQEAgLTE3NDQsNDYgKzE3NDQs
MjcgQEAgRVhQT1JUX1NZTUJPTChmYXVsdF9pbl93cml0ZWFibGUpOwogICovCiBzaXplX3QgZmF1
bHRfaW5fc2FmZV93cml0ZWFibGUoY29uc3QgY2hhciBfX3VzZXIgKnVhZGRyLCBzaXplX3Qgc2l6
ZSkKIHsKLQl1bnNpZ25lZCBsb25nIHN0YXJ0ID0gKHVuc2lnbmVkIGxvbmcpdW50YWdnZWRfYWRk
cih1YWRkcik7Ci0JdW5zaWduZWQgbG9uZyBlbmQsIG5zdGFydCwgbmVuZDsKKwl1bnNpZ25lZCBs
b25nIHN0YXJ0ID0gKHVuc2lnbmVkIGxvbmcpdWFkZHIsIGVuZDsKIAlzdHJ1Y3QgbW1fc3RydWN0
ICptbSA9IGN1cnJlbnQtPm1tOwotCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hID0gTlVMTDsK
LQlpbnQgbG9ja2VkID0gMDsKKwlib29sIHVubG9ja2VkID0gZmFsc2U7CiAKLQluc3RhcnQgPSBz
dGFydCAmIFBBR0VfTUFTSzsKKwlpZiAodW5saWtlbHkoc2l6ZSA9PSAwKSkKKwkJcmV0dXJuIDA7
CiAJZW5kID0gUEFHRV9BTElHTihzdGFydCArIHNpemUpOwotCWlmIChlbmQgPCBuc3RhcnQpCisJ
aWYgKGVuZCA8IHN0YXJ0KQogCQllbmQgPSAwOwotCWZvciAoOyBuc3RhcnQgIT0gZW5kOyBuc3Rh
cnQgPSBuZW5kKSB7Ci0JCXVuc2lnbmVkIGxvbmcgbnJfcGFnZXM7Ci0JCWxvbmcgcmV0OwogCi0J
CWlmICghbG9ja2VkKSB7Ci0JCQlsb2NrZWQgPSAxOwotCQkJbW1hcF9yZWFkX2xvY2sobW0pOwot
CQkJdm1hID0gZmluZF92bWEobW0sIG5zdGFydCk7Ci0JCX0gZWxzZSBpZiAobnN0YXJ0ID49IHZt
YS0+dm1fZW5kKQotCQkJdm1hID0gdm1hLT52bV9uZXh0OwotCQlpZiAoIXZtYSB8fCB2bWEtPnZt
X3N0YXJ0ID49IGVuZCkKLQkJCWJyZWFrOwotCQluZW5kID0gZW5kID8gbWluKGVuZCwgdm1hLT52
bV9lbmQpIDogdm1hLT52bV9lbmQ7Ci0JCWlmICh2bWEtPnZtX2ZsYWdzICYgKFZNX0lPIHwgVk1f
UEZOTUFQKSkKLQkJCWNvbnRpbnVlOwotCQlpZiAobnN0YXJ0IDwgdm1hLT52bV9zdGFydCkKLQkJ
CW5zdGFydCA9IHZtYS0+dm1fc3RhcnQ7Ci0JCW5yX3BhZ2VzID0gKG5lbmQgLSBuc3RhcnQpIC8g
UEFHRV9TSVpFOwotCQlyZXQgPSBfX2dldF91c2VyX3BhZ2VzX2xvY2tlZChtbSwgbnN0YXJ0LCBu
cl9wYWdlcywKLQkJCQkJICAgICAgTlVMTCwgTlVMTCwgJmxvY2tlZCwKLQkJCQkJICAgICAgRk9M
TF9UT1VDSCB8IEZPTExfV1JJVEUpOwotCQlpZiAocmV0IDw9IDApCisJbW1hcF9yZWFkX2xvY2so
bW0pOworCWRvIHsKKwkJaWYgKGZpeHVwX3VzZXJfZmF1bHQobW0sIHN0YXJ0LCBGQVVMVF9GTEFH
X1dSSVRFLCAmdW5sb2NrZWQpKQogCQkJYnJlYWs7Ci0JCW5lbmQgPSBuc3RhcnQgKyByZXQgKiBQ
QUdFX1NJWkU7Ci0JfQotCWlmIChsb2NrZWQpCi0JCW1tYXBfcmVhZF91bmxvY2sobW0pOwotCWlm
IChuc3RhcnQgPT0gZW5kKQotCQlyZXR1cm4gMDsKLQlyZXR1cm4gc2l6ZSAtIG1pbl90KHNpemVf
dCwgbnN0YXJ0IC0gc3RhcnQsIHNpemUpOworCQlzdGFydCA9IChzdGFydCArIFBBR0VfU0laRSkg
JiBQQUdFX01BU0s7CisJfSB3aGlsZSAoc3RhcnQgIT0gZW5kKTsKKwltbWFwX3JlYWRfdW5sb2Nr
KG1tKTsKKworCWlmIChzaXplID4gKHVuc2lnbmVkIGxvbmcpdWFkZHIgLSBzdGFydCkKKwkJcmV0
dXJuIHNpemUgLSAoKHVuc2lnbmVkIGxvbmcpdWFkZHIgLSBzdGFydCk7CisJcmV0dXJuIDA7CiB9
CiBFWFBPUlRfU1lNQk9MKGZhdWx0X2luX3NhZmVfd3JpdGVhYmxlKTsKIAotLSAKMi4zNS4xLjM1
Ni5nZTY2MzBmNTdjZi5kaXJ0eQoK
--00000000000011bc1705d9cecf39--
