Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC448EEBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbfHOOy2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 10:54:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39404 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfHOOy2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 10:54:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id x3so1836892lfn.6
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2019 07:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OWGym05P4A79pj/lEUQgvusiq3Zt0dAtYuM2TTca9NA=;
        b=Redzjyxq4CbJ20GKAa/hHHzCTXnrweVeC8KGkAbyw1oDvOK9N4ZX6K24aU5+wUer33
         NyIXX93y+jMVmV22TH9NrxT8zGWDQs2KzKoH23PQjHTJFh3Q1D6zM9z60AW57PTWFAlR
         RNJRpkVJYC11yPRJqOWxrOdghpBvU9O0sBn8mqApvgYIKw5Di1V73lqzU4NottGj/+BB
         yqaOY/W9QHQse7F0ecnPwxPPC7NBpXqJDCKRe2bzViSa1rAGBPnSZ2wGhHzp+QwAunMU
         pIhQfSZ8xbk2jNO4EinYErLzZxy45YMvVtCCcjEkMJAijo1vmRRN5HQK3+bGfMKtahCv
         WPkA==
X-Gm-Message-State: APjAAAX5++fkI0fz04j6HPYDJcNUWZkBaZWj0MqO9FOhVjtgBJBOF8aX
        PJBp8bmFwLoH4mKSVNuQWj0ALyCAaAI=
X-Google-Smtp-Source: APXvYqzLEGN9K3xeQ5PXnDQJolbtyIXKzG7idnzQZ1JxzuCeyFzF8dVAUvBjV0+DtWeudMaG25VTJQ==
X-Received: by 2002:a19:674d:: with SMTP id e13mr2603437lfj.176.1565880866418;
        Thu, 15 Aug 2019 07:54:26 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id t1sm518964lji.52.2019.08.15.07.54.25
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 07:54:26 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id z17so2513489ljz.0
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2019 07:54:25 -0700 (PDT)
X-Received: by 2002:a2e:85d7:: with SMTP id h23mr2964081ljj.129.1565880865491;
 Thu, 15 Aug 2019 07:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190815020453.25150-1-git@thecybershadow.net>
 <20190815020453.25150-2-git@thecybershadow.net> <3a375f8c-2d13-6f23-6731-85667c92c21c@oracle.com>
In-Reply-To: <3a375f8c-2d13-6f23-6731-85667c92c21c@oracle.com>
From:   Vladimir Panteleev <git@thecybershadow.net>
Date:   Thu, 15 Aug 2019 14:54:08 +0000
X-Gmail-Original-Message-ID: <CAHhfkvzcTbVRmPOd0SHHESLYuV6zGRuuRKfczieaS9KGx3zypA@mail.gmail.com>
Message-ID: <CAHhfkvzcTbVRmPOd0SHHESLYuV6zGRuuRKfczieaS9KGx3zypA@mail.gmail.com>
Subject: Re: [PATCH 1/1] btrfs: Simplify parsing max_inline mount option
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 15 Aug 2019 at 04:54, Anand Jain <anand.jain@oracle.com> wrote:
>   This causes regression, max_inline = 0 is a valid parameter.

Thank you for catching that. Apologies for making such a rudimentary mistake.

I will apply more diligence and resubmit.
