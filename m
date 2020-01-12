Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E8A138835
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jan 2020 21:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbgALU1d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jan 2020 15:27:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36354 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732825AbgALU1d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jan 2020 15:27:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so6612335wru.3
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jan 2020 12:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hp/WEo/3sd14q106+xbjRr+ptb43g9oc7qOC9+msCSg=;
        b=DL8MRXbuTJzoouSWCB2Qso/Dqmf2j5NoPg7GCIFmCo7Vd2+OvKz/e7zOu0gC9s1dgt
         CBghu+7LpeB1Pr85OGbFSHVMiTFikeFQP8viVxVRozbpMJDbBzw9GW9dcXhNvHwpSKcr
         sWVU8pJHs7Yj0Z+IzKwLWqTI4S0ZxtpF2xxYs1thKOylZEYQcWDjYOBp1o/ev1DX1NB0
         lCA7TndRyvRr8nua0278j0vz5+hgd/KxjScat1/5GRHx89aig6dAFjIX4vfz1cjAudI6
         EYK1KGldRkPunWBp/MWL+fp0PJoOemSHF/Nk1jhQMlScbJXITxWls6hNZfKM3a6aIU+2
         8ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hp/WEo/3sd14q106+xbjRr+ptb43g9oc7qOC9+msCSg=;
        b=mWEb60Qt/XQVDHj9xJ7L4ETCn2dxebE19hh7arP2vHI0AvztCbyCg+RxOhhVZtvbnA
         otp22y3OAuEA8tk7JGyCfwSmBu/AMdKlNqkgugA7RUjhD/MJPSYKA6tlghNL0P15jypc
         4mkplvAu+eOExab+T6QbE/ILsiKrqDwaYauOjwGAeS6MY82VNwaSwEteovDNmgR3tp0V
         CjiwANvh8OLvHLGI3/42TwcJWkivwTUSTS/TaUlGWRpmzDePuafw6zJ5bYx2D1RrO/q3
         t/cGWZoj2LgUjb8cecwrBPaDf/FbgDDtBIGTLMYGBNopWGVv+02lpOBD05x7gsVzpH66
         SuXw==
X-Gm-Message-State: APjAAAXEDh51AJeGFecdisutbvy38kAtD14x7ak1lzSfYOx57NfKc4X3
        tJIFLZYzWhIZVujMmkZoJuutH5EaKOThuvaLUwvgqg==
X-Google-Smtp-Source: APXvYqwkJT8sPPsgaYT8WTwrEw1jic9/2qtGBa8U8tzjKv2yKS3Nspi95KwbRrlvwXObYMn4NUKaAU+VIhQ5qlxQTyg=
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr15282229wrm.262.1578860851148;
 Sun, 12 Jan 2020 12:27:31 -0800 (PST)
MIME-Version: 1.0
References: <3283de40c2750cd62d020ed71430cd35@philip-seeger.de>
 <d89fe4da-c498-bb24-8eb5-a19b01680a23@cobb.uk.net> <ac61f79a3c373f319232640db5db9a5e@philip-seeger.de>
 <2a9bf923-e7b9-9d82-5f1d-bbdfc192978e@suse.com> <d3a234a07192fd9713b0ac33123c99db@philip-seeger.de>
 <68ebf136-6aff-bd98-cf95-0c3c7d5bed89@philip-seeger.de> <9b6d7519-cffb-2cfa-5e77-b514817b5f0a@gmail.com>
 <2ddeb325-7c53-5423-8b14-8393c6928350@philip-seeger.de> <01a333c2-b3fc-128c-073a-d7b4d455f13c@dirtcellar.net>
In-Reply-To: <01a333c2-b3fc-128c-073a-d7b4d455f13c@dirtcellar.net>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 12 Jan 2020 13:27:15 -0700
Message-ID: <CAJCQCtTjEiimpuwy1kwPx73QcArhB7_Z3gjP_UWh1==2f7dg-Q@mail.gmail.com>
Subject: Re: Monitoring not working as "dev stats" returns 0 after read error occurred
To:     waxhead <waxhead@dirtcellar.net>
Cc:     Philip Seeger <philip@philip-seeger.de>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 12, 2020 at 10:39 AM waxhead <waxhead@dirtcellar.net> wrote:
>
> Speaking of... it would be great if btrfs device stats /mnt (or some
> other command) could offer to show a list of corrupted files with paths
> (which I assume the filesystem know about). That would make restoring
> files from backup a breeze!

Scrub does this. As well as any time a corrupt file is read. But such
information isn't stored anywhere. Path to file is reported in kernel
messages.

-- 
Chris Murphy
