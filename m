Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A37B8138D25
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 09:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgAMIpg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 03:45:36 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:39701 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgAMIpf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 03:45:35 -0500
Received: by mail-io1-f48.google.com with SMTP id c16so8913881ioh.6
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2020 00:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IMRGb9rujZ0z4Sz8TAE8UWGj2vF7AKhc7z+7UqKjM8U=;
        b=tzz46v93IMDF0cq3SE5ZdJbu/7MIf4fLRK3qS2gakpSbO/thmAgGhOZ8tgCpZ15kuw
         7aKncyFNTTADaC12rnURgfw8F5uw5JghReZmZ8TYSW3ul2SRBiWkj4IfSXRsIF6tDIh1
         UV6s43XKz5HrKC4PB6CO48jb08wPj7NrPBGJwB3ZGBI1qmZuCRBH6kVSy7AiOKeTp/tX
         HVmXdvG6xcs6VVMHO0IPZrFRdrdIpJXH4qQxRJwZU2/rSZuYxZlzKyNkTDW96hYAdRMN
         TBsWCGgTwatvLTIjvQqJyaOtVzkYrQsEM9KJfDPgDgQpOJnFOaQ39SoOUw72+JDFXXHq
         i7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IMRGb9rujZ0z4Sz8TAE8UWGj2vF7AKhc7z+7UqKjM8U=;
        b=IYxeHONHGy9UXxKTb5WD4ugWz+c4/U2sIC6Kl2kIrwHgkG51GF0ZLbDZ6jWYWBzp6j
         3zhP6b31CshPLbG2Ls7/Q1A5l7Zdf5DObKV4hWZBochw9oT5FLPOiH8EHYQFNuwCOvWh
         VDR4CwbWm4rG3ojTWyZ5DYBfUSokaOu6FvEjWr5vHMy5I6k9r0en8W2bG231VRZKuwkC
         L/j7F69xfBnp5PVbTFZIa1KNrRPKzmEzaoDkFsfInqe5qabgy8MSI0DVkGSCiHdEC8UZ
         9ptFxTgqETOvd/IZ6hhLC0MkcBXrRIugaJU/FBGJZNz0tqShyc4PAhR/BXCSAsZsY7DZ
         bynQ==
X-Gm-Message-State: APjAAAWvfFm410gnKQwS5pZloVYOIejAeCqub1TUkh127IxfNc7emQpB
        DN89xgi9o3OzxeBHeekczIhgW5n2VamQTME3NQLnkw==
X-Google-Smtp-Source: APXvYqxaY/5sBnPf947wtIVCXSb4T3NGrYJKQA2M3AEekZeXByNx3JGcmbSES30cmPYH6r20ECqOzxSSDysh1aDRYTs=
X-Received: by 2002:a6b:7316:: with SMTP id e22mr12118108ioh.205.1578905135026;
 Mon, 13 Jan 2020 00:45:35 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Sebastian_D=C3=B6ring?= <moralapostel@gmail.com>
Date:   Mon, 13 Jan 2020 09:45:24 +0100
Message-ID: <CADkZQanp1_gHJyvhbZz1BNBToamAO9027zH7SjuxMg9nezkzQQ@mail.gmail.com>
Subject: Converting from one csum hash algorithm to another?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi there,

just a quick question: Will it be possible to convert existing btrfs
to a different csum hash? It seems viable to re-read all
data&metadata, verify existing checksums, and then recalculate a new
one.

I'm pretty excited about the inclusion of xxhash and am wondering if I
have to recreate the whole fs at some point...
