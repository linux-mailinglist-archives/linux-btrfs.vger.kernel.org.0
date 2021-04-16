Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0BB362398
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 17:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245527AbhDPPN7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 11:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245350AbhDPPN0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 11:13:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09261C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 08:12:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a4so27061415wrr.2
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jFyYAgByPINy7XdO2+RcUO7qOed4hltE4uYBRvzRbVw=;
        b=m38PSC9iGGeWx/0esoEEeHDPgTbMY2zZiwjSjUqdvcCJxO8043pUd9u8LN+wbuvGoS
         9IAwtR1/3LVxwPKtd03AsI4NWo0a9OGtWUnMc6czjQJa8LfpGzgAG3lgl3+bbWXXJfHa
         fP1rwp0fS/wQpi7UQIsadE5P9tYeg5tq3sQQbl6kcqULuye3bESduFDm5/QGtgJLLA5v
         uFI1M8dI42NzzhJfXdtQDOpl2ksdCYrATgqz2w9KvLgieNbzrJ45nOQBXUIj96hy+hOK
         bNxZMRGCIn0LisemWNs7VJj4juBxKD6S9eTBsgI0CJkSaYXimfwcBwkGB3pmzPkdpYL1
         m9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=jFyYAgByPINy7XdO2+RcUO7qOed4hltE4uYBRvzRbVw=;
        b=cHpairrt6b5inMkhjJEHJXy6Tg1L80sTugXYXTufplq9wbyF3W02fIQCBIJoCN2sPl
         AVmheb/cpYA+IYHTFeLwm6SBduRZDczpzqFWvcdcbdsR7hFXAklVnKDjxJYGpRy2wIbF
         X1d2Kysaerbq3uItU4XGH62dOD2S6YrPmF2iW3Hsh7IAwLkl2s9JMgdbES9FpA2RTajp
         2T+9qPkoYpkRnPt6IinUtz4V/MbpuhQBTGV/ipgYDVouvJy+IyqpasHxojPXGKj5aDIP
         ZbG2k1AFUxBv/2EWbcUnhBZZkZdNfeX+vX/EQFjbpew0neRGVXij+A5aD1qoi6wLEFKD
         HQIQ==
X-Gm-Message-State: AOAM532AD3pMFR4SvW3Ue4Aje1IMSZNAm5NYmo+NRqbzuRG+4GJ/5gKv
        89w19XnpFg3zxGMkJMa6QA0h5oaZGdqKgSJSyhU=
X-Google-Smtp-Source: ABdhPJySZyxiVO69PLcLukIPRytf2IZbhIyxQBvmkwzIUvb5/nots/wcVftGv3eJAjR1yl3CL0uzgZmXHf1PkrgLxwU=
X-Received: by 2002:adf:c587:: with SMTP id m7mr9447322wrg.369.1618585964842;
 Fri, 16 Apr 2021 08:12:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e94b:0:0:0:0:0 with HTTP; Fri, 16 Apr 2021 08:12:44
 -0700 (PDT)
Reply-To: atmcarddelivery001@post.com
From:   vick chioma <vickc8381@gmail.com>
Date:   Fri, 16 Apr 2021 15:12:44 +0000
Message-ID: <CABpG5H4UiLpOwQxU8CiofDqz8pW-zU8zAwt9XnZ6G=zw9iZOLQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

INCj0LLQsNC20LDQtdC80Lgg0L/QvtCx0LXQtNC40YLQtdC7LA0KDQrQkdC40YUg0LjRgdC60LDQ
uyDQtNCwINCy0Lgg0L/QvtC30LTRgNCw0LLRjyDQt9CwINGC0LDQt9C4INCy0LXQu9C40LrQsCDQ
v9C+0LHQtdC00LAsINC60YrQtNC10YLQviDQsNC3DQrQtNC+0YHRgtC40LPQvdCwINCy0LDRiNC4
0Y8g0LjQvNC10LnQuyDQsNC00YDQtdGBLiDQmNGB0LrQsNC8INC00LAg0LfQvdCw0LwsINGH0LUg
0LvQvtGC0LDRgNC40Y/RgtCwINC+0YLQvdC10LzQsA0K0LzRj9GB0YLQviDQstGB0Y/QutCwINCz
0L7QtNC40L3QsCAoTW9sb3R0ZXJ5IDIwMjApLiDQotC+0LLQsCDQtSDRg9C10LHRgdCw0LnRgiwg
0LrRitC00LXRgtC+INC80L7QttC10YLQtQ0K0L/RgNC+0LLQtdGA0LXRgtC1INCz0L46IChodHRw
czovL3d3dy5sb3R0ZXJ5dXNhLmNvbS9taXNzb3VyaS9sb3R0by95ZWFyKS4NCg0KKNCf0LXRh9C1
0LvQuNCy0Ygg0L3QvtC80LXRgDogMTAtMTQtMjktMzAtMzYtMzkpDQoNCtCb0L7RgtCw0YDQuNGP
OiAyLDYg0LzQuNC70LjQvtC90LAg0LTQvtC70LDRgNCwDQoNCtCS0YHQuNGH0LrQuCDRg9GH0LDR
gdGC0L3QuNGG0Lgg0LHRj9GF0LAg0LjQt9Cx0YDQsNC90Lgg0YfRgNC10Lcg0LrQvtC80L/RjtGC
0YrRgNC90LAg0YHQuNGB0YLQtdC80LAg0LfQsCDQs9C70LDRgdGD0LLQsNC90LUNCtGB0YrRgdGC
0LDQstC10L0g0L7RgiDQv9C+0YLRgNC10LHQuNGC0LXQu9C4INC90LAgTWljcm9zb2Z0IC8gWUFI
T08gLyBHTUFJTCAvIE1BSUwuUlUvSU5CT1guTFYg0YENCtC/0L7QstC10YfQtSDQvtGCIDIwIDAw
MCDQutC+0LzQv9Cw0L3QuNC4INC4IDMgMDAwIDAwMCDQuNC80LXQudC7INCw0LTRgNC10YHQuC4g
0Lgg0YPQvdC40LrQsNC70LXQvQ0K0LjQvNC10L3QsCDQvtGCINGG0Y/QuyDigIvigIvRgdCy0Y/R
gi4NCg0K0JLRgdGK0YnQvdC+0YHRgiDQstCw0YjQuNGP0YIg0LjQvNC10LnQuyDQsNC00YDQtdGB
INC1INC10LTQuNC9INC+0YIg0LjQt9Cx0YDQsNC90LjRgtC1INC40LzQtdC50Lsg0LDQtNGA0LXR
gdC4DQrQutC+0LnRgtC+INGB0L/QtdGH0LXQu9C4INC90LDRhtC40L7QvdCw0LvQvdC+INGB0L/Q
vtC90YHQvtGA0LjRgNCw0L3QsNGC0LAg0LvQvtGC0LDRgNC40LnQvdCwINC40LPRgNCwIChNb2xv
dHRlcnkgMjAyMCkg0YLQvtCy0LANCtCz0L7QtNC40L3QsC4NCg0K0JLRgdC40YfQutC+LCDQutC+
0LXRgtC+INGC0YDRj9Cx0LLQsCDQtNCwINC90LDQv9GA0LDQstC40YLQtSwg0LfQsCDQtNCwINC8
0L7QttC10YLQtSDQtNCwINC/0L7Qu9GD0YfQuNGC0LUg0L/QsNGA0LjRgtC1INGB0LgsINC40LfQ
v9GA0LDRgtC10YLQtQ0K0L/RitC70L3QsNGC0LAg0LLQuCDQuNC90YTQvtGA0LzQsNGG0LjRjyDQ
t9CwIEJhcnIgQW5keSBjaHVrd3Ug0YEg0YLQvtCy0LANCg0K0LjQvNC10LnQuyBbd2VzdHVuaW9u
dG9nb3VuaW9ucGF5bWVudEBnbWFpbC5jb21dDQoNCtCp0LUg0L/QvtC70YPRh9C40YLQtSDQv9Cw
0YDQuNGC0LUg0YHQuCDRh9GA0LXQtyDQutCw0YDRgtCwINC30LAg0LHQsNC90LrQvtC80LDRgiBW
SVNBINCy0YrQsiDQstCw0YjQsNGC0LAg0YHRgtGA0LDQvdCwDQrQuCDRidC1INC40LfRgtC10LPQ
u9C40YLQtSDQv9Cw0YDQuNGC0LUg0YHQuCAyLDYg0LzQuNC70LjQvtC90LAg0LTQvtC70LDRgNCw
Lg0KDQrQn9C+0LTQsNC50YLQtSDQv9GK0LvQvdCw0YLQsCDRgdC4INC40L3RhNC+0YDQvNCw0YbQ
uNGPDQoNCtCS0LDRiNC10YLQviDQv9GK0LvQvdC+INC40LzQtSAuLi4uLi4uLi4NCtCi0LLQvtGP
0YLQsCDRgdGC0YDQsNC90LAgLi4uLi4uDQrQktCw0YjQuNGP0YIg0LDQtNGA0LXRgSAuLi4uLg0K
0KLQstC+0Y/RgiDQs9GA0LDQtCAuLi4uLi4NCtCS0LDRiNC40Y/RgiDRgtC10LvQtdGE0L7QvdC1
0L0g0L3QvtC80LXRgCAuLi4uLg0K0JLQsNGI0LjRj9GCINC/0L7RidC10L3RgdC60Lgg0LrQvtC0
IC4uLi4uLi4uDQoNCtCY0LfQv9GA0LDRgtC10YLQtSDQv9GK0LvQvdCw0YLQsCDRgdC4INC40L3R
hNC+0YDQvNCw0YbQuNGPINC00LjRgNC10LrRgtC90L4g0L3QsCBCYXJyIEFuZHkgY2h1a3d1INGB
INGC0L7QstCwDQrQuNC80LXQudC7IHdlc3R1bmlvbnRvZ291bmlvbnBheW1lbnRAZ21haWwuY29t
INCx0LvQsNCz0L7QtNCw0YDRjywg0L3QsNC00Y/QstCw0Lwg0YHQtSDQtNCwINGH0YPRjw0K0L7R
giDQstCw0YEg0YEg0LLQsNGI0LDRgtCwINC/0YrQu9C90LAg0LjQvdGE0L7RgNC80LDRhtC40Y8g
0LjQu9C4INC80L7QttC10YLQtSDQtNCwINC80Lgg0Y8g0LjQt9C/0YDQsNGC0LjRgtC1INGC0YPQ
ug0K0Lgg0YnQtSDQstC4INCz0L4g0LjQt9C/0YDQsNGC0Y8sINGD0YHQv9C10YUuDQo=
