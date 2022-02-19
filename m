Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B954BC530
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Feb 2022 04:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbiBSDOx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 22:14:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbiBSDOv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 22:14:51 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2D550471
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 19:14:33 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id gi6so569490pjb.1
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 19:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=jIEW3GEt2R7+faVgElOQ+eB8QHchlLoAIZOgRqlmF+w=;
        b=nFxNrxgKsn3u5c5QVCNIaTit3piqJv5yqsTv0yumKaMosUhPxt3AuODyVA+VFwqQ/Z
         vSjmdfhDmI4YRXR0WvgZkqs8IAKO/E1EE+baV+QfCyIvrNssVlrzgfeRv+JUV9yruRlI
         ZG8uxyPnNUDcNv8M7Nc+lcgCsjgNw2undK8zTiYIGbKuUuQ0LdLbtsvge88u0Qhe5F3V
         sWXBoGYzzuqSVKjfsN3uWt8SsqhmFoQWLiMvMbgo6At4jrqCu5KohFEir8SeY95rRnKl
         GYK7unL2ghpkAfPf3R44MDtLN4X7CvkCF5pXGU4RE5wCKK3er/pnSybZk/Ocy7CV3beq
         grEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jIEW3GEt2R7+faVgElOQ+eB8QHchlLoAIZOgRqlmF+w=;
        b=iwowhpgLtkeOupL4PgwauelLsje8ZFi/DAY0hlsTwngaMMPCJbD9t6K0W8izauKnRf
         Zz+de8XrG/Vxnp1AHB6VEowrLOuY1m2OB4kElDNyehlVO1RWvYMJbFdDrhYlbsN/eJJ1
         pGn2QnaWiflO6JEk2AK9UAStzYOs5aBWkbMCJyuhpetdsGD71CRTXMK2lWtRjSYBj+Ba
         F0Mny6rKwcgPxc1BaHP67wRtEnu+Ua6O5e4x6Jvevo+xYpjSjsP7TGetU/XdL+HOKvx6
         vGvhx3XRrudNTuUi/0iIi7YfmGxTyoe4ug85EvPXIENQtUnAXCw9/oqcI8qIUcVxsQuR
         A/7Q==
X-Gm-Message-State: AOAM533zaUfzvuEq6TLlLZ3hq4C8Y42SvIrJEgbzMA5I1CD27OkxB0+J
        iZ8dUtu4bRT74Qb38vUpJgWm6TYNTwg9KifkLktq+W4i
X-Google-Smtp-Source: ABdhPJzicPzCbpsMfB0Z64Vvor7keYqAkoqKPTMLRC2IFK6pqbbnTqKQaM+4I54nzmvUmEh8lG+UE5R9HO//fNZSNys=
X-Received: by 2002:a17:90a:c981:b0:1b8:b14b:6913 with SMTP id
 w1-20020a17090ac98100b001b8b14b6913mr11275849pjt.131.1645240472696; Fri, 18
 Feb 2022 19:14:32 -0800 (PST)
MIME-Version: 1.0
From:   ov 2k <ov2k.github@gmail.com>
Date:   Fri, 18 Feb 2022 22:14:20 -0500
Message-ID: <CADwZqEvZQmwnY7e5LcUmgQ7EMmMx1XV-znnQMJG3D_fKtpDcdw@mail.gmail.com>
Subject: FIDEDUPERANGE and compression
To:     linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f20aee05d8566541"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--000000000000f20aee05d8566541
Content-Type: text/plain; charset="UTF-8"

FIDEDUPERANGE does not seem to behave as expected with compressible
data on a btrfs volume with compression enabled, at least with small
adjacent FIDEDUPERANGE requests.  I've attached a basic test case.  It
writes two short identical files and calls FIDEDUPERANGE three times,
on the thirds of the file, in order.  filefrag -v reports that the
destination file has three extents that each reference the first third
of the source file.

To be clear, the data in the destination file remains correct.
However, the second and third FIDEDUPERANGE calls do not seem to cause
the destination file to reference the expected source extents.  I'm
not actually certain whether this is a bug in FIDEDUPERANGE or
FS_IOC_FIEMAP or something deeper within btrfs itself.

--000000000000f20aee05d8566541
Content-Type: text/x-c-code; charset="US-ASCII"; name="test.c"
Content-Disposition: attachment; filename="test.c"
Content-Transfer-Encoding: base64
Content-ID: <f_kzt9mrsa0>
X-Attachment-Id: f_kzt9mrsa0

I2luY2x1ZGUgPGxpbnV4L2ZzLmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGli
Lmg+CiNpbmNsdWRlIDxzeXMvaW9jdGwuaD4KI2luY2x1ZGUgPHN5cy9zdGF0dmZzLmg+CiNpbmNs
dWRlIDx1bmlzdGQuaD4KCmludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikgewoJRklMRSAq
c3JjOwoJRklMRSAqZGVzdDsKCXN0cnVjdCBzdGF0dmZzIHZmc3N0YXRzOwoJdW5zaWduZWQgbG9u
ZyBic2l6ZTsKCXNpemVfdCBzaXplOwoJc3RydWN0IGZpbGVfZGVkdXBlX3JhbmdlICpmZHI7CgoJ
c3JjID0gZm9wZW4oInNyYyIsICJ3KyIpOwoJZGVzdCA9IGZvcGVuKCJkZXN0IiwgIncrIik7CgoJ
ZnN0YXR2ZnMoZmlsZW5vKHNyYyksICZ2ZnNzdGF0cyk7Cglic2l6ZSA9IHZmc3N0YXRzLmZfYnNp
emU7Cglmb3Ioc2l6ZV90IGkgPSAwOyBpIDwgYnNpemUgKiAyOyBpKyspIHsKCQlmcHJpbnRmKHNy
YywgIiVzIiwgImZvbyIpOwoJCWZwcmludGYoZGVzdCwgIiVzIiwgImZvbyIpOwoJfQoKCWZmbHVz
aChzcmMpOwoJZnN5bmMoZmlsZW5vKHNyYykpOwoJZmZsdXNoKGRlc3QpOwoJZnN5bmMoZmlsZW5v
KGRlc3QpKTsKCglzaXplID0gc2l6ZW9mIChzdHJ1Y3QgZmlsZV9kZWR1cGVfcmFuZ2UpOwoJc2l6
ZSArPSBzaXplb2YgKHN0cnVjdCBmaWxlX2RlZHVwZV9yYW5nZV9pbmZvKTsKCWZkciA9IGNhbGxv
YygxLCBzaXplKTsKCWZkci0+c3JjX2xlbmd0aCA9IDIgKiBic2l6ZTsKCWZkci0+ZGVzdF9jb3Vu
dCA9IDE7CglmZHItPmluZm9bMF0uZGVzdF9mZCA9IGZpbGVubyhkZXN0KTsKCglmb3Ioc2l6ZV90
IGkgPSAwOyBpIDwgMzsgaSsrKSB7CgkJaW9jdGwoZmlsZW5vKHNyYyksIEZJREVEVVBFUkFOR0Us
IGZkcik7CgkJZmRyLT5zcmNfb2Zmc2V0ICs9IDIgKiBic2l6ZTsKCQlmZHItPmluZm9bMF0uZGVz
dF9vZmZzZXQgKz0gMiAqIGJzaXplOwoJfQoKCWZmbHVzaChkZXN0KTsKCWZzeW5jKGZpbGVubyhk
ZXN0KSk7CgoJcmV0dXJuIDA7Cn0K
--000000000000f20aee05d8566541--
