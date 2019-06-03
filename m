Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE31E33BE5
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2019 01:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfFCXZs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 19:25:48 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:33241 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfFCXZr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jun 2019 19:25:47 -0400
Received: by mail-ot1-f46.google.com with SMTP id p4so951932oti.0
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jun 2019 16:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gGR97mANOEimUAyWt3T4Wy5OkxjSr7h/YpZeEZYEUJE=;
        b=jzdIhLhe5AVDqNxO0UXxtMgiGru/hZsotlEoFVLIW2W1CuY9EZejzGM6x4ruqT9fOy
         EiXCBiZIXcBZ4ncqK9HnXt9J32y/69UVVTh2GuodMjArpDQ0Bz3askl0Pgy9zubkvJeA
         nszJ/2Ma3+0Xi7YvrVtshemYj6ZzI5/jmvGVwO3f0knK2MsiTY6YFROsZRZJwasF2Kas
         Qqr2N9tOZl6kENf0GOAoBn4VpPg7ZSR0EQco2xnSAS57SjBaIqMwV66ZrOThoggOIOUB
         IbK3SmolpnVCR5WbkawaudkEQMiCMaZ7ssVbpZsq/VupaZIWpNALCala58XId77yQu2x
         paeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gGR97mANOEimUAyWt3T4Wy5OkxjSr7h/YpZeEZYEUJE=;
        b=Jvf2TfzKltpvkR0/whSHL2B4guoKVIN2oYAD7+WDe6UG8sJ7oH3bqT+ONE0hMjJeq3
         DOG7rDmHWy+5+xZdad0y+DMmd//zuQ1BXWu6Ydw+wuztCdDnCw+aXgYagudDMHCWYviL
         JrjGQ2U93FHxqfjCYJCOYDlqqg/kEX+XBJB1YEvVA9jniFPYpRWyPHgTt9r5TUQP8ToY
         CSHk+Oll4TyvlCXmrS+2z5Q0uQTHTqCGiSEx6f+xoo/MYuMuV/q8DscGLQyyJUFdxnyw
         K7fj7+xQ/ZnmhJvdWy3XgCox/O6A35he6iUcwuuTHI6VH7gRCTTuyD/SXbNFrgDmT3Sm
         SbuQ==
X-Gm-Message-State: APjAAAXw+hc8zVMNfxZ9zGcVX1mlOwypPM9YvPzorFd0SFw7jY4bnDBe
        XHSaH9sidqHeuwPfkZL9pt1P8WJM7tSRIoHuq39p8a6yids=
X-Google-Smtp-Source: APXvYqwuUAD4VsCe71yWVOb6yZdbIqJ7nDadKCXGfLG6BzVp65DO5bq8vI/lK4AupMf4MPLxMjYqU+bTlMalpYaZBjA=
X-Received: by 2002:a9d:661:: with SMTP id 88mr2978001otn.214.1559604346745;
 Mon, 03 Jun 2019 16:25:46 -0700 (PDT)
MIME-Version: 1.0
From:   Michael Adams <unquietwiki@gmail.com>
Date:   Mon, 3 Jun 2019 16:25:35 -0700
Message-ID: <CACVqEWkAQzFF3MuA4ghBUjvEBdQNSuuPH7geMntQOeKdVYwoiQ@mail.gmail.com>
Subject: Attempt to fix Github Issue #59 for btrfs-progs (looping issue)
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm in the middle of a projected 92TB btrfs restore to another server
and kept having issues keeping the restore going past the first 200GB.
I created an "Ignore" option for the loop question, mentioned in issue
#59; and it's managed to restore several terabytes so far.

https://github.com/kdave/btrfs-progs/issues/59#issuecomment-497917965

https://github.com/unquietwiki/btrfs-progs/commit/6f4959237077b8fc95339167ecdd07241c8db937

-- 

Michael Adams
https://unquietwiki.com/
