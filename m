Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AEB3FB5E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 14:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbhH3MUV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 08:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbhH3MTU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 08:19:20 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4530C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 05:18:26 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id f6so7752697vsr.3
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 05:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TzW6TXnfq8OtLTLQdwOY4LZWcnWKKswJe+qqMF/4SPw=;
        b=MWy3QCO7uSUYGQuCbhLoNcvH9QoRFq93s9qL3pGHre7PyWQCX4uzt9h3GxpIlRWFkS
         rGUKXhnaT3fZhQdDTR4XP6enBNcNFMUTe8ie9PRsB4nC1dbIKc54sCGZDx/Qb7jkOGv0
         2xOVS4Gj1TOz3SSIlRZE9KWHDQgVBZUBEmZmSSWv5+Kp/OEJtY6kzc0fOVvfmt3zhuwX
         uA/fMoLnIlNivIBD0q0XWmcWB+rohC5xx9PvHHCoc7eg1l1ry8gLu3e5hi5hrVyYAyBb
         vc+zsRNpS25MGPvlZU6DcllygSIGcTFJx40bteZH6P7T2gbybrCVLjTM96CgOVaK7YdK
         k3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=TzW6TXnfq8OtLTLQdwOY4LZWcnWKKswJe+qqMF/4SPw=;
        b=c2oXWJZJ9w82sYxcmzHtXXVUzLF1h3Rw8kYuT5odQ13/EqZP9YIb+/hEks0KgGWGL1
         XnCXvgFJ+sSxjAreHMFexxcEci1RdYyl2hgk8rUEm2u/U5nhBVWbhyK7Qp4WSOvbXjuJ
         dbx+nRvkx//bglHGqd0qWovimsvzbeRm27/pkBsMa4Aoy/mbyNMZqmF3/0J5GlkcZEje
         5x7St4RsneuqLjDV6RcIlHK/OCw7MD8AH1KdAUqZE7K8kP8ybecBV/Is3MPyzL2kLxD0
         lern1feYTnrCfV4/B6Ilz8v+weSIOof78y+FyD5BUeUqP8aG3p8Y3q6KOhbMl29ak3Xf
         mXNg==
X-Gm-Message-State: AOAM532qja9DlJOPYSzPmVDNzc3Huy3hurQdG9/Dnpx8Uo7a3dC0/j8d
        t1oGj54fTUyW9T9/mb2sYjwgQVRunzyYrrFthuE=
X-Google-Smtp-Source: ABdhPJxqi+Kw1GEpvAFtOcggrksBazmg6Hj5ydVUq86kovsibluyjuQmxET1VF+i7AsAjN24VdLfKztNgdEJoBiutVc=
X-Received: by 2002:a67:d216:: with SMTP id y22mr9101922vsi.40.1630325905757;
 Mon, 30 Aug 2021 05:18:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6102:2fa:0:0:0:0 with HTTP; Mon, 30 Aug 2021 05:18:25
 -0700 (PDT)
Reply-To: rolandnyemih200@gmail.com
From:   Rowland Nyemih <guedjouirene@gmail.com>
Date:   Mon, 30 Aug 2021 13:18:25 +0100
Message-ID: <CACrAO7Crj846-hxs9zC5OpaqqaW8hAi2opgvb2yAn5sTUsRmug@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SGVsbG8sDQpJIGNhbGxlZCB0byBrbm93IGlmIHlvdSByZWNlaXZlZCBteSBwcmV2aW91cyBlbWFp
bCwgcmVwbHkgdG8gbWUNCmFzYXAuDQpSb3dsYW5kDQoNCg0K7JWI64WV7ZWY7Iut64uI6rmMLA0K
7J207KCEIOydtOuplOydvOydhCDrsJvslZjripTsp4Ag7ZmV7J247ZWY6riwIOychO2VtCDsoITt
mZTtlojsirXri4jri6QuIOuLteyepeydhCDrs7TrgrTso7zshLjsmpQuDQrstZzrjIDtlZwg67mo
66asLg0K66Gk656c65OcDQo=
