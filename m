Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 316E71130FC
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2019 18:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfLDRnD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 12:43:03 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:39015 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfLDRnC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 12:43:02 -0500
Received: by mail-lj1-f173.google.com with SMTP id e10so269065ljj.6
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 09:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AqMj6FDiFI4TwPB5GhHJClklxkYRJHed2sUujgB5lKM=;
        b=kL6dGSAN/f9gSZ35g3GWKjaB/oLwMQPQAR+cKzzbyViEAgqzY2JDi0kmEEJyyhLZws
         sf5OIkaBfcod5eD1HWgKNFSwp0A7q/1ZSxqlklsxfSSRjEHjqHnMo7ElRY+gRVy4IoBP
         CdQMoFQ9iq/tRFPBR/DisFb2VOs2iXV1k6s/UG/ULLNq9+q66vokllwUPPnEfXgVz00T
         1jDj9BRh2TJPq8hDjGclRXMbvIHCh4HFGs6PES1s+BT6XZBjuQuLBwOQbD2Sm2wpSHF+
         LLAY3tFZ3Epap356YY2tf6hMs8YreOeNhPVvhJy28jjTumedGwjq43jxkw5oR5x8DIkZ
         bw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AqMj6FDiFI4TwPB5GhHJClklxkYRJHed2sUujgB5lKM=;
        b=stGGEffYZBfi5giwYfhpEYaeCq8PY3a/9S/uNcEykDpWvlUayppWLmOjZiX7xEopYo
         0mERz41WuDJc5pPW37NpvN89tFgW6DyFxEWze9L/g9k7aosW3tNBIzmwo0qTnRf0Qrg0
         aW9fcl0FvYBrU+hyfxPn9J1xnDfg6N296kQJHbfqiAAfF5a4Td9rVSypgsA7wrm5qgsE
         n/WUIDbEVLCmpW/csrcMlREm/+BehMYPku/SlPz1Tuc4ej4eNc54v4aQP5PoG4Go0D/l
         LwsmIct5DRPVhRiMa3LqC5XRsQV3hlJuPu4DyHGo084SXHEHtlmjyiwPM+/4sWHKKtQp
         T/Jw==
X-Gm-Message-State: APjAAAUOsuCvdXqH7OTHbRw4P04svj/OaZQmWlDov/QpZSvndhjvc7Jr
        hMl3s1qVhQs0qaEF/H8owKe/B9OVAcZ3ySsVMzInxZlk
X-Google-Smtp-Source: APXvYqz15KoCx2I/TJMdgLY7FpUVm45EDiN/Um1wU+nbbzGVGTRYF+sSianMIt5ybI1Ib8RsBUqSZ78nc2vL2ObX3Cw=
X-Received: by 2002:a2e:7816:: with SMTP id t22mr2793559ljc.161.1575481380997;
 Wed, 04 Dec 2019 09:43:00 -0800 (PST)
MIME-Version: 1.0
From:   pk <pkoroau@gmail.com>
Date:   Wed, 4 Dec 2019 18:42:50 +0100
Message-ID: <CAMNwjE+xs55e6qQLuG-YiwHb3dyq915hRqsnm_c5j9fcvwT5uA@mail.gmail.com>
Subject: ping for null pointer dereference (cppcheck)
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205003
