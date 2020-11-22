Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF412BC9A3
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Nov 2020 22:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgKVVsR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Nov 2020 16:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgKVVsP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Nov 2020 16:48:15 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68C4C0613CF
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Nov 2020 13:48:13 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id gj5so20609671ejb.8
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Nov 2020 13:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=holMzMixu6L4mPkY4KLX0AXrH3B7KLU6Q1+gVZ1hbDo=;
        b=fMqC6ZwWf0wO+ZfAqCHUjizbjVooGH9h3sdREj5fn9Dx28kLFRRujUdBwtgEF5Mr2b
         Q+7upQNwzVddsRdx3IhvE7zc0FOLvUatiVpfS2n0fiZ+IeD2GFqAJwS2oc9E/3ZC+f10
         CjIpRlbPv+MKcsd+j8w2bHjnWcOt6v2XBRvkhYOu7Cws0XpBrMwQiBINbFC4QRii6QeC
         1jja8qkRn2iWwYH4zL07eZVRjXR78XW2AcfpHISlXpvolvHJ5cdBpyWzqNQ3BB3KYo9w
         XbZv9iwEdRepDNdtoVc9tgcen+652G0TCWSvaPQlf6ISpoSO+j6bNgd2G2n+K1upiHqL
         FX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=holMzMixu6L4mPkY4KLX0AXrH3B7KLU6Q1+gVZ1hbDo=;
        b=rw4bZDZXcoiTBJb1n33CobTrV0eOO51itKggYtYK0lFGGUXgtQW8/ojo6oWs/Qtljr
         5LGgDAiY/fkkqPdg9/f6X5Jd0yay9JG3z20xsweYKzP2Zs7wwNmteUv8UxUEv/KCF0XH
         6m/YM4nfyXKNDcCf3YwN4hLxMpzGRUL+ETfCn9G/Mpyf9vJ4QqFczLSihRyrNbbX2r8R
         O5X/y83ERLaTQ+wy3k6pOlvnpyNB7UmfncvHJtGuEtyft9S/HOzR9oYv1C3jxVfKNAcl
         rMYPgaNdw6QnDZdaVkcm+M2AhVksturX18EMG5xeLc81EhJ31OZ98RQFQtsbN1cVRzAW
         877A==
X-Gm-Message-State: AOAM531IlVILL6dbDwQslE3rIH7fUygIZRUDsdpZlDwI/nfDH58lYodY
        eFtjFZ0UkaYMN+8HQnJQRY4=
X-Google-Smtp-Source: ABdhPJz1E8ynlMbh88pIvsOg/LZ4O/5x5dcwOCrdymHA35GKsql4rtQFV9ComdM5RNL9OLL+p5asBQ==
X-Received: by 2002:a17:906:80ca:: with SMTP id a10mr42843766ejx.351.1606081692505;
        Sun, 22 Nov 2020 13:48:12 -0800 (PST)
Received: from [192.168.43.48] ([197.210.35.67])
        by smtp.gmail.com with ESMTPSA id e17sm4016232edc.45.2020.11.22.13.48.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Nov 2020 13:48:11 -0800 (PST)
Message-ID: <5fbadc9b.1c69fb81.8dfc7.11a2@mx.google.com>
Sender: Baniko Diallo <banidiallo23@gmail.com>
From:   Adelina Zeuki <adelinazeuki@gmail.com>
X-Google-Original-From: "Adelina Zeuki" <  adelinazeuki@gmail.comm >
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hello !!
To:     Recipients <adelinazeuki@gmail.comm>
Date:   Sun, 22 Nov 2020 21:48:01 +0000
Reply-To: adelinazeuki@gmail.com
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi dear,

Can i talk with you ?
