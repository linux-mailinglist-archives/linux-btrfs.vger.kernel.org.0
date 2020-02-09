Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B295156890
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Feb 2020 04:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgBIDqX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Feb 2020 22:46:23 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42294 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgBIDqX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 8 Feb 2020 22:46:23 -0500
Received: by mail-wr1-f45.google.com with SMTP id k11so3428258wrd.9
        for <linux-btrfs@vger.kernel.org>; Sat, 08 Feb 2020 19:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wTIaKZkPfv53JXhchcnUAEfa8/73COHEQSGu0QdU0bw=;
        b=DkjyfDs6Q+2bLHwM9rb18Xa+apjEmLUJ4va5yAj5FsmiSWMmSNQCrb8skBttw1iz5h
         wr0OAWETiCgV3lH2chbUOvDfOB4k/j5Wvf8JCXC5H9c9hTQnhczduxQE6hJ9avVF06sI
         iSvGB42cjys7XqQnhEU9IC5ScCLXGjfQQHUYJ8b9XXMsc3k5BsoSbRR57vJpd5u0fxkP
         edNKuRfiPv9Axe+zVT9L1vBaOM732xleGpo42whGiHyTeeQ59Ed8P7qcmhqqgIneYF/x
         fXoXVS8Kx7yZSq0IvGAsz1FiI2KZt8xe7VsOaFuTE8x+gN8a3cp3X8Ex3yJXRFj2aOPW
         5FOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wTIaKZkPfv53JXhchcnUAEfa8/73COHEQSGu0QdU0bw=;
        b=FCudm+VpjHFDc26EbULtCC6bU3BC/K7SwYRfjm1Q9y62l4ooe0ZcADLFhMV8ixHkYm
         HJI0Hf6JBbLH7/x9lefurZ3xp+n3HGc17nn3sJdEu5GtlAZaj0Xyep2mwE2Gy7P9NtkF
         b9bw74swl5T8iBHrAJhM/HGwkp+aInLxJ43jmYWtI4gQ9iFcyQuTgTSPfNPgDfYbJTfh
         RQoyJzkIzXlEkkPmnNE8xM4C2Ptn9jYH/QGTuDx/fno1yf/8P9rncJqszLubJlN8GhOC
         0g4SYX+jTjB/KQMJJZP4rKjBQMj9ji46TvOxGW/veLgzibmxwqgoYS/3/PPOrdaux+fq
         zcAA==
X-Gm-Message-State: APjAAAWV0EkIvGW4hfXDMvITavpDyZnT+peEkEQxjZqibKF9waysQtiV
        KVRa8vYmbee5J/Sl8lYH8csMmJjbLnh78usLcNF+Gg==
X-Google-Smtp-Source: APXvYqyV1kIDbgYlWlNlpQtDBi7vmVu6zLBAKprhXfhL+xQKWqQvBcVMkVmuVEVEqOkJqs7dmEyEmmxD0oE+Fh3Nwkc=
X-Received: by 2002:adf:ab14:: with SMTP id q20mr8362099wrc.274.1581219981102;
 Sat, 08 Feb 2020 19:46:21 -0800 (PST)
MIME-Version: 1.0
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft9ANwKT1+ENS6-w9HLtdx0MDOiVhi5RWKLucaT_WtZLkg@mail.gmail.com>
 <40b47145-f965-ec5f-2caf-68434c4fbc62@gmx.com> <CA+M2ft8zMv8nhs6VzZWnzgcP2nRasrwxLzjKgaZPnm_prtWQow@mail.gmail.com>
 <3e5f4de7-fec1-f8cd-c8b1-20b5a3f38f60@gmx.com> <CA+M2ft_6_1pkP75G79qj4dLxOjJr0bOGtATaGPTVQGn25sAo+A@mail.gmail.com>
In-Reply-To: <CA+M2ft_6_1pkP75G79qj4dLxOjJr0bOGtATaGPTVQGn25sAo+A@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 8 Feb 2020 20:46:04 -0700
Message-ID: <CAJCQCtRoL+zbLpZtZX2kev5t-cA3Oa4f0+88gW2yhVnMpc7Cpg@mail.gmail.com>
Subject: Re: btrfs root fs started remounting ro
To:     John Hendy <jw.hendy@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 8, 2020 at 12:57 PM John Hendy <jw.hendy@gmail.com> wrote:
>
> This was with btrfs-progs 5.4 (the install USB is maybe a month old).

5.4.1 is current and has extra checks for extent items, although I
have no idea if the extent problems you're running into are fixable
with the 5.4.1 enhancements.


-- 
Chris Murphy
