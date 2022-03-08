Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F0F4D2167
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 20:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244826AbiCHT24 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 14:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239799AbiCHT2z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 14:28:55 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1637029CB3
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 11:27:58 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id w12so9707885lfr.9
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 11:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e3tyhZcTT5clPSsfgGSWeMIMTPV1eQ06G1tymibw6gs=;
        b=aqDqW0jKuhDTNMpf9AsVdDMH6RT/Ezu0dBsTBUUQ4vX5oqqv49dTEHgxErfyishTTc
         S+eIKJZN2WvBq3cMo8TTWiHLnHHSrH07K61PMqdSsV2ggvRfAy3/wo2t8JO6dsCpZ6oa
         +nhIlcK37MdeSXNbbYFPMD1h8wTUj0XPqv5NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3tyhZcTT5clPSsfgGSWeMIMTPV1eQ06G1tymibw6gs=;
        b=guiwk5mbDxIJ/Mepj2u8VepUR5h7I6VYsLTsd3SLL45MQuE/3ImJnlWGYjZuDLp8Ju
         vBcAOHlWvvhfNuNFpBbjSS+6bv1/HD3gD2KHDg15Ltq0l2gzKtzJ2F/7v9gu6qr+v0zS
         HkzLdA6QvM33u2TLmONb+0Q6B1LWJhDHt0JxQs2JsqfS/LfGOamUav9qd8v8Umti/sGC
         5q6jx5uKKID57lONiwZR/i4Ncuj+EKWHw6DjqYAxCADeSV9Wmyd6asAwbzcUsiKieY0s
         tYj3GLyXYCauO1XCXb4bCco7lt74t/FFy8CzVuZfakUEytlubI/xAO18K8cG/TXGylfz
         WrEQ==
X-Gm-Message-State: AOAM532baGaJApSOa6aukw550jd5F74FFfQSBu4BcEvN8bVlTDEvhp8R
        IOhzG0gvMm1QfonSdcfEcrl4iBH1kiYgqHfDHt8=
X-Google-Smtp-Source: ABdhPJylmsXQ7pAP1AeOefPrf7hGgMEkGXBLt+L9W3eG2upd/XhNg2xaLr3ZZggVKudeMHnWIdkKLA==
X-Received: by 2002:a05:6512:2081:b0:443:3d6f:b676 with SMTP id t1-20020a056512208100b004433d6fb676mr11649444lfr.453.1646767676116;
        Tue, 08 Mar 2022 11:27:56 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id h1-20020ac25961000000b004483c8359f6sm646840lfp.21.2022.03.08.11.27.55
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 11:27:55 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id r22so37356ljd.4
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 11:27:55 -0800 (PST)
X-Received: by 2002:a2e:804b:0:b0:247:e81f:87e9 with SMTP id
 p11-20020a2e804b000000b00247e81f87e9mr6717778ljg.176.1646767674964; Tue, 08
 Mar 2022 11:27:54 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
In-Reply-To: <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 11:27:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
Message-ID: <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     David Hildenbrand <david@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000004c1c4a05d9b9fadf"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--0000000000004c1c4a05d9b9fadf
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 8, 2022 at 9:40 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. The futex code actually uses "fixup_user_fault()" for this case.
> Maybe fault_in_safe_writeable() should do that?

.. paging all the bits back in, I'm reminded that one of the worries
was "what about large areas".

But I really think that the solution should be that we limit the size
of fault_in_safe_writeable() to just a couple of pages.

Even if you were to fault in gigabytes, page-out can undo it anyway,
so there is no semantic reason why that function should ever do more
than a few pages to make sure. There's already even a comment about
how there's no guarantee that the pages will stay.

Side note: the current GUP-based fault_in_safe_writeable() is buggy in
another way anyway: it doesn't work right for stack extending
accesses.

So I think the fix for this all might be something like the attached
(TOTALLY UNTESTED)!

Comments? Andreas, mind (carefully - maybe it is totally broken and
does unspeakable acts to your pets) testing this?

                         Linus

--0000000000004c1c4a05d9b9fadf
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l0iixtc20>
X-Attachment-Id: f_l0iixtc20

IG1tL2d1cC5jIHwgNDAgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL21tL2d1cC5jIGIvbW0vZ3VwLmMKaW5kZXggYTlkNGQ3MjRhZWY3Li45ZTA4NWU3Yjlj
MjggMTAwNjQ0Ci0tLSBhL21tL2d1cC5jCisrKyBiL21tL2d1cC5jCkBAIC0xNzQ1LDQ0ICsxNzQ1
LDI4IEBAIEVYUE9SVF9TWU1CT0woZmF1bHRfaW5fd3JpdGVhYmxlKTsKIHNpemVfdCBmYXVsdF9p
bl9zYWZlX3dyaXRlYWJsZShjb25zdCBjaGFyIF9fdXNlciAqdWFkZHIsIHNpemVfdCBzaXplKQog
ewogCXVuc2lnbmVkIGxvbmcgc3RhcnQgPSAodW5zaWduZWQgbG9uZyl1bnRhZ2dlZF9hZGRyKHVh
ZGRyKTsKLQl1bnNpZ25lZCBsb25nIGVuZCwgbnN0YXJ0LCBuZW5kOworCXVuc2lnbmVkIGxvbmcg
ZW5kLCBuc3RhcnQ7CiAJc3RydWN0IG1tX3N0cnVjdCAqbW0gPSBjdXJyZW50LT5tbTsKLQlzdHJ1
Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSA9IE5VTEw7Ci0JaW50IGxvY2tlZCA9IDA7CisJY29uc3Qg
dW5zaWduZWQgaW50IGZhdWx0X2ZsYWdzID0gRkFVTFRfRkxBR19XUklURSB8IEZBVUxUX0ZMQUdf
S0lMTEFCTEU7CisJY29uc3Qgc2l6ZV90IG1heF9zaXplID0gNCAqIFBBR0VfU0laRTsKIAogCW5z
dGFydCA9IHN0YXJ0ICYgUEFHRV9NQVNLOwotCWVuZCA9IFBBR0VfQUxJR04oc3RhcnQgKyBzaXpl
KTsKKwllbmQgPSBQQUdFX0FMSUdOKHN0YXJ0ICsgbWluKHNpemUsIG1heF9zaXplKSk7CiAJaWYg
KGVuZCA8IG5zdGFydCkKIAkJZW5kID0gMDsKLQlmb3IgKDsgbnN0YXJ0ICE9IGVuZDsgbnN0YXJ0
ID0gbmVuZCkgewotCQl1bnNpZ25lZCBsb25nIG5yX3BhZ2VzOwotCQlsb25nIHJldDsKIAotCQlp
ZiAoIWxvY2tlZCkgewotCQkJbG9ja2VkID0gMTsKLQkJCW1tYXBfcmVhZF9sb2NrKG1tKTsKLQkJ
CXZtYSA9IGZpbmRfdm1hKG1tLCBuc3RhcnQpOwotCQl9IGVsc2UgaWYgKG5zdGFydCA+PSB2bWEt
PnZtX2VuZCkKLQkJCXZtYSA9IHZtYS0+dm1fbmV4dDsKLQkJaWYgKCF2bWEgfHwgdm1hLT52bV9z
dGFydCA+PSBlbmQpCi0JCQlicmVhazsKLQkJbmVuZCA9IGVuZCA/IG1pbihlbmQsIHZtYS0+dm1f
ZW5kKSA6IHZtYS0+dm1fZW5kOwotCQlpZiAodm1hLT52bV9mbGFncyAmIChWTV9JTyB8IFZNX1BG
Tk1BUCkpCi0JCQljb250aW51ZTsKLQkJaWYgKG5zdGFydCA8IHZtYS0+dm1fc3RhcnQpCi0JCQlu
c3RhcnQgPSB2bWEtPnZtX3N0YXJ0OwotCQlucl9wYWdlcyA9IChuZW5kIC0gbnN0YXJ0KSAvIFBB
R0VfU0laRTsKLQkJcmV0ID0gX19nZXRfdXNlcl9wYWdlc19sb2NrZWQobW0sIG5zdGFydCwgbnJf
cGFnZXMsCi0JCQkJCSAgICAgIE5VTEwsIE5VTEwsICZsb2NrZWQsCi0JCQkJCSAgICAgIEZPTExf
VE9VQ0ggfCBGT0xMX1dSSVRFKTsKLQkJaWYgKHJldCA8PSAwKQorCW1tYXBfcmVhZF9sb2NrKG1t
KTsKKwlmb3IgKDsgbnN0YXJ0ICE9IGVuZDsgbnN0YXJ0ICs9IFBBR0VfU0laRSkgeworCQlpZiAo
Zml4dXBfdXNlcl9mYXVsdChtbSwgbnN0YXJ0LCBmYXVsdF9mbGFncywgTlVMTCkpCiAJCQlicmVh
azsKLQkJbmVuZCA9IG5zdGFydCArIHJldCAqIFBBR0VfU0laRTsKIAl9Ci0JaWYgKGxvY2tlZCkK
LQkJbW1hcF9yZWFkX3VubG9jayhtbSk7CisJbW1hcF9yZWFkX3VubG9jayhtbSk7CisKKwkvKiBJ
ZiB3ZSBnb3QgYWxsIG9mIG91ciAodHJ1bmNhdGVkKSBmYXVsdC1pbiwgd2UgY2xhaW0gd2UgZ290
IGl0IGFsbCAqLwogCWlmIChuc3RhcnQgPT0gZW5kKQogCQlyZXR1cm4gMDsKKworCS8qIC4uIG90
aGVyd2lzZSB3ZSdsbCB1c2UgdGhlIG9yaWdpbmFsIHVudHJ1bmNhdGVkIHNpemUgKi8KIAlyZXR1
cm4gc2l6ZSAtIG1pbl90KHNpemVfdCwgbnN0YXJ0IC0gc3RhcnQsIHNpemUpOwogfQogRVhQT1JU
X1NZTUJPTChmYXVsdF9pbl9zYWZlX3dyaXRlYWJsZSk7Cg==
--0000000000004c1c4a05d9b9fadf--
