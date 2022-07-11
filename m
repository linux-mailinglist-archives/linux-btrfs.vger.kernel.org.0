Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68A0570658
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 16:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiGKO5o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 10:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGKO5n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 10:57:43 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8037172C
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 07:57:42 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 64so9108301ybt.12
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 07:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=m97C7/ya+jok4noGk+m281RRj3/0IRE2QlIcqqwFSzY=;
        b=W+/aJlUqTSyFFSnHr36jeNKL5SjeWl11v0Q9A1k+hJNr1bZf2ztgtKKmQmwoHbOSeH
         jGxvPJTzuydWEkTCAFzE99CAk3bYl0ppGyA1khtJrnOlgh5EjyovKOtnDIbX2yYTY/mD
         6zbWMTbFtpzncUCocrg6Dk0T18IUc8xRlg2Sue/e3V6CdI+3bxSRaBZcFnJ1Zw+aBmWL
         +EqgsV3Av7tMJ+PpE4Ub8WdFCfFrlEc/tuoGh5VBfwAfmKWWGWhrd4gzPc0RZ5T0CUe6
         ZCah1ke8Xum4njAUd14vaUk5cOSNMTFLeTBFa+NXHXNB6hyIkye0V8oCoCieiktekCWH
         eceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=m97C7/ya+jok4noGk+m281RRj3/0IRE2QlIcqqwFSzY=;
        b=TRn+uYciEeTLNfDRWk7kpbcozOe2cFIYluO8yxM+5kuIwdKSJyYyaYV2fWZmfdmkvT
         kY3LQAbrQzp38NoEP6ZNv0FRqPZWXB81LSjUX1X6W8TCGq9AAzMj9udal0b2yuk7uyHh
         YBITSjDuXo7oTCJnVTeurymmDrjOWpODlt/TIE2GWs8+/LvSzMDzWE3nkk/uRPMhBlAa
         wcRfsSS0KrQ8gScxI6OytH+QQs3ATz7ngzkgj3dGfK68AUs3hLzjgWw4F8zJ8w3XTTcG
         0BjDTzeVr5OxcBdy+wnZnS5e8ClDytGYrvi2FLopj3mDzbGwHYqV2cHV7lritUTeR6Bn
         OYSg==
X-Gm-Message-State: AJIora+5beibwVuqkkdYkrNBeHbSSbDzOoC7PZJcszxxsWDXCk74MIny
        ArKqNM/uvQr10dJHXmqHw5ayn9GB0xYA/5KVixs=
X-Google-Smtp-Source: AGRyM1salNGS/l5BEh6me9QX9zKd+LVr1SblQX6e4SlNdn5gZnCrzqecOLRj/YZlHTSVwkPEhxvPRFbeJorNN6UHdLQ=
X-Received: by 2002:a25:aea4:0:b0:66e:3abd:1abf with SMTP id
 b36-20020a25aea4000000b0066e3abd1abfmr17548089ybj.512.1657551461742; Mon, 11
 Jul 2022 07:57:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:80a6:b0:1eb:2198:eed7 with HTTP; Mon, 11 Jul 2022
 07:57:41 -0700 (PDT)
Reply-To: orlandomoris56@gmail.com
From:   Orlando Moris <ayanasuamukamara123@gmail.com>
Date:   Mon, 11 Jul 2022 14:57:41 +0000
Message-ID: <CADUKyEAwbVfuUPFhLjQ=nmRUhBdsntLOK_=PrJZ_+RocA4_B5w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b35 listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ayanasuamukamara123[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ayanasuamukamara123[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [orlandomoris56[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

=C4=B0yi g=C3=BCnler, posta kutunuza gelen bu e-postan=C4=B1n bir hata olma=
d=C4=B1=C4=9F=C4=B1n=C4=B1,
=C3=B6zellikle nazik de=C4=9Ferlendirmeniz i=C3=A7in size g=C3=B6nderildi=
=C4=9Fini unutmay=C4=B1n.
Rahmetli m=C3=BCvekkilim M=C3=BChendis Carlos'un ($7.500.000.00) bir teklif=
i
var, ailesiyle birlikte bir araba kazas=C4=B1nda ac=C4=B1l=C4=B1 =C3=B6l=C3=
=BCm=C3=BCnden =C3=B6nce
burada (Lome Togo) =C3=A7al=C4=B1=C5=9Ft=C4=B1 ve ya=C5=9Fad=C4=B1, en yak=
=C4=B1n akrabas=C4=B1 olarak sizinle
ileti=C5=9Fime ge=C3=A7iyorum. talep =C3=BCzerine fonlar=C4=B1 alabilirsini=
z. h=C4=B1zl=C4=B1
yan=C4=B1t=C4=B1n=C4=B1z =C3=BCzerine sizi modlar=C4=B1 hakk=C4=B1nda bilgi=
lendirece=C4=9Fim
bu s=C3=B6zle=C5=9Fmenin y=C3=BCr=C3=BCt=C3=BClmesi, bu e-postadan bana ula=
=C5=9F=C4=B1n
(orlandomoris56@gmail.com )
