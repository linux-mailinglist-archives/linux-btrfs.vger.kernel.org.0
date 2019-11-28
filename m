Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CACA10C15F
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 02:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfK1BXp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 20:23:45 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:35512 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbfK1BXp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 20:23:45 -0500
Received: by mail-wr1-f46.google.com with SMTP id s5so29019012wrw.2
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2019 17:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+fcuwvMCRziJ/N4d2u+3J1tnJLlV385BHcsg8oKn1g=;
        b=Ehwo9jvlkMoP52/ejMOF35obku4QoEZE73e+e2T1DaUChlbkDH8Q1MkOvyZl1UUVIg
         M/wUo8dKRbn3f/1ySvF8Y17rCO8aQ6yXF2nKZMOy1KheL3I3LWwUDMLrZDC3HC8qoHIZ
         ZmikGvDQCJRGovCht6saBq+45q3NvmEnvGTTnJovF8Wzy2PsTnVcHcUmavclUvO9xHWT
         MaqBJmEz+tq30tOvPh6VPeqDg21g2kLX0pF0gPqnzNuuYnF/vMMHO2fpNS71Wgcf8seZ
         Kjh/aVJz94sUwwVzvEpSStLRqtfqkQrfo1a2eXIEb5HglQyiIJpVKWx1vO0Ch54WuCcF
         fWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+fcuwvMCRziJ/N4d2u+3J1tnJLlV385BHcsg8oKn1g=;
        b=Izm1GvsNiuogqO8T4DLa73yi6RQTBVMmHWXA0WvFu3Y+RV611qmdtnngTB6AOPK37X
         uO491jsVmXcj9YfwdZx+VgPkKQ1KTrl9/B+iM71v6VjIC7Sq0AiAg9ZOAWQHV3gX6pK3
         BgNpREwqGu6/TsEj3+1mZsUFvX8OIwAPdp5ws52ajnIIn69TPkhYNGo8G6FfwixDsKrp
         miv4wutebwMIfdI7ynzdV6O37MuS3Hkj/r62Hl5/l3mymiDcQnSJDX1aaXV8+US7xVkS
         HteRojqdCL1mW7AodsSIhPWLI9DCwCtcRAIhVZm2s5YkNIS2gOz2sLSx7h7+PO0EBhgt
         kD4A==
X-Gm-Message-State: APjAAAUoQ86yNWKpw97rxDfO+wFZe7C4QQOLQBHh/2PhMSBlTbBQ5glH
        5DiLl8kGzjfvyDSs+OXbgIgANI2zCEoM1gt7yFK+vQ==
X-Google-Smtp-Source: APXvYqykYKc83BfndJnSsRri6hzSO7WLhAvQWDJI0iYmA1ajTLLPRLhgjm1m6Zozn93zJ/sp7uyYi8HbCtZEKa4pTis=
X-Received: by 2002:adf:da52:: with SMTP id r18mr45307845wrl.167.1574904223218;
 Wed, 27 Nov 2019 17:23:43 -0800 (PST)
MIME-Version: 1.0
References: <CAGsZeXsEZ8EqPsuU9O+7d+suxBVNQAobASJaLNMZB9LhUe6Q7A@mail.gmail.com>
In-Reply-To: <CAGsZeXsEZ8EqPsuU9O+7d+suxBVNQAobASJaLNMZB9LhUe6Q7A@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 27 Nov 2019 18:23:27 -0700
Message-ID: <CAJCQCtSUZDUe+_J01wZkDLGT7sSe0YYmYnTE9HBaJ1CA9r30qg@mail.gmail.com>
Subject: Re: bad sector / bad block support
To:     Christopher Staples <mastercatz@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 26, 2019 at 8:30 PM Christopher Staples
<mastercatz@gmail.com> wrote:
>
> will their ever be a better way to handle bad sectors ?  I keep
> getting silent corruption from random bad sectors
> scrubs keep passing with out showing any errors , but if I do a
> ddrescue backup to a new drive I find the bad sectors

Bad sectors manifest in two ways: the drive reports UNC on read or
write, or Btrfs reports a checksum mismatch.

If Btrfs isn't catching it, but the data is wrong, it's probably a
memory problem that causes the corruption and subsequently a checksum
computation based on that corruption which is why Btrfs thinks it's
correct.

> I like btrfs for the snapshot ability , but when it comes to keeping
> data safe ext4 seems better ? at least it looks for bad sectors and
> marks them , btrfs just seems to write and assumes its written ..

That's the wrong way of looking at it.

If there are a small number of bad physical sectors, upon write, the
drive firmware will remap the LBA to a reserve sector. There's no
appearance of bad sectors outside the drive at all, and no error
reported. That's normal behavior. If the drive has a lot of bad
sectors, eventually all the reserve sectors get used up, and now the
drive has to report UNC on write - a write error. This is a device
that's inevitably going to betray you with far worse problems and data
loss, so papering over it with an external bad sector map isn't
something anyone will recommend in a data integrity context. Replace
the drive.

-- 
Chris Murphy
