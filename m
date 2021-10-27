Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE3443C2FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 08:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbhJ0GaJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 02:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhJ0GaI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 02:30:08 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956B4C061570
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 23:27:43 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so2189473ote.8
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 23:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=VshUeeDSetU21+5KOh1TQAi9UpwH/OaoqJFGVrdYCmA=;
        b=OOfZH/X23Z06bkdYBJ9cDt2NVdcqy2X9rhwFVnDprBd+j2Hbcom8DUugO8vZOa7Uxg
         +qDZDjEa9l61rri/Uq/VDZ6LppAtWFyL4Ml08lRs4r+s9+mrmJExifTPDd5lN7ovAmcs
         XQYvtCf3S4UWNDqzazKAmYpKnK61+I4LkvHwE0VPfZOndV919BVaAJl/4h1t9ugWtHFg
         X2GH/Fhy2vbZPBaHn0qZ1k/cGPRYRcbtLkHnn1E6AEKGNEdjOqbOgEqiLvZSQ7OPRmIP
         epC9ur3FdXJkVTJ18T33r7GlG5HtWJXVS3t+10GqG1y58HXdnd7J3ArOg0PLgY3XDvPL
         hPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=VshUeeDSetU21+5KOh1TQAi9UpwH/OaoqJFGVrdYCmA=;
        b=ysH7IYw6E/Z3YjCwFZ+mV5GpkDr0uqXCwJBmuhf1GACzRPCwEkCnI47VSBaiDRKfMR
         0/fhxldnE3khF/obQt3m2PKjAbSZwHuPLFNA1xKFpS5my6oS4hgpAoNqyAsfrE/JQ1Ng
         Z8D/eQrqe2rBEAbIojYNQ3bXZejTVz8M8hXxL/5xVqzJCiqcdCm9ABxow6UJaiIVwoQO
         fwOfLoPXHRYIHTkfvFiBrJ8WstAJttKh0xaVlasL9JdCPL+liQ4GrNOjRhkBDv0wbTRo
         alzqBOo3eGlXT5hBJUb3G9u8y8LGH41STrjRfsY8VSW4od1gF0H4qEEW8eN0N2ktBDCc
         2V0A==
X-Gm-Message-State: AOAM532qY4axUSChN5wG2jTqXYzrLWx4bEwzA7b9hCQJpDnjIhlWaWeB
        MUOoHAU0o3odo8Slrt7ha+X13iwnHk+7g0EbjQ==
X-Google-Smtp-Source: ABdhPJwNc6HIl6dva2rexA3jeJPSBBvT8cTqzxfXy9aojfs5Vrwqz/VZq5tlGG9E+siGblK/TR69T+Wzghliv7SiZ5Y=
X-Received: by 2002:a9d:6092:: with SMTP id m18mr22940056otj.384.1635316062943;
 Tue, 26 Oct 2021 23:27:42 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrmohammedmashab@gmail.com
Sender: mohamearbaoui@gmail.com
Received: by 2002:a4a:e1c5:0:0:0:0:0 with HTTP; Tue, 26 Oct 2021 23:27:42
 -0700 (PDT)
From:   Mr Mohammed Mashab <mrmohammedmasha@gmail.com>
Date:   Tue, 26 Oct 2021 23:27:42 -0700
X-Google-Sender-Auth: 1jn7QVJ_8PKoCeFilL9G1s8zZ-8
Message-ID: <CAGqXaywQw6L7e5U87VZKG1-aGw6GbUn7W3d+YhyRrERC=rQ2Hw@mail.gmail.com>
Subject: From: Mr.Mohammed,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Good Day,

I am Mr. Mohammed Mashab, account Manager with an investment bank here
in Burkina Faso. There is a draft account opened in my firm by a
long-time client of our bank. I have the opportunity of transferring
the left over fund (15.8 Million Us Dollars) Fiftheen Million Eight
Hundred Thousand United States of American Dollars.

I want to invest this funds and introduce you to our bank for this
deal and this will be executed under a legitimate arrangement that
will protect us from any breach of the law. We will share the fund 40%
for you,50% for me while 10% is for establishing of foundation for the
poor children in your country. If you are really interested in my
proposal further details of the fund transfer will be forwarded to
you.

Yours Sincerely,
Mr. Mohammed Mashab.
