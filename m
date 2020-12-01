Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0712CA4D7
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Dec 2020 15:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbgLAOBj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Dec 2020 09:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387744AbgLAOBj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Dec 2020 09:01:39 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6DCC0613D4
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Dec 2020 06:00:59 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id t33so1928244ybd.0
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Dec 2020 06:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iCXfAXR+gAQt6+z9o6y7MQcrVQTmwfK00M3VVz2w75o=;
        b=XqbHT7oaTkgM7rb9bZipPdFWUJGmCOlBGFPMa+BSvNyj+nOAUT7CFQq/fM5ja0FMKP
         VFl3qncVYDD8YRUc03SXFXExN/XZBhrgJ0UsxpRH6Zh3NQnrfajDmnnyrmbaSq6k4oqU
         FA1FixJ7RBl8jQyiBRaMHYBYhDN9DWRW4kjaCGzrk7/CnZQ8s3BKPsYdJoTxBQts7WTx
         D6M9FMDRWbeerk4Ta4BD8IoryGKxd3hW/dyQV0VNwFdptY+ODGBs573Ur1P0B0WB6NgQ
         sjEV1fqE93MjE771ZERUhTmFBVtTgEsofLGhg9Qe6y72xeIizYqq5Ei4Fu3LstA0UXjk
         6fSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iCXfAXR+gAQt6+z9o6y7MQcrVQTmwfK00M3VVz2w75o=;
        b=ugeRMq+Al9szI+M2Gm3i6Q5QAlgXKyY/rem0MkrWo0w26GiBWtn5ttHt8SI+h5BFFp
         Jd1HRIfxb2sk+RzqigIgQ8TOb/k16QTNc6nLErG1PDDnP9Hkz8KHwnZhJ5JiDCU9qpLl
         T7vRN2nKwqML87si5OBILh3Bq9/bAcFZrP9tXXm0mZpyQWnTw3iopUrKpipmf9WnrA+k
         CPfjdx+Hv0fVGhd2CpCG8PITQIgbho4uM2KH2QxCI/236ERZ831Hfqrr2XfAW9hMfXYQ
         D9whx2vKajfD65+/PIbWVpmwCxS0ciDJ7SEM9SDzaPj0IwWtnq/hjiVPL31RPhBjShdI
         +QKw==
X-Gm-Message-State: AOAM530BNIPUGr/lgvwU7LsVUcX1jv84GB5XCX2NDfAPwKO6Zxh6gFdY
        uj4w4+vTVN1q6oLTbiipZ9dngqYzFHmIrAyk9ZUnVfFCEig=
X-Google-Smtp-Source: ABdhPJxlN8lJvkQIvZvtsbqhxFAB8cTxzkmY52rTPgBtfdOvwRLepCOPjhxwbJk7aNdsYrkqYcdntxYNhYfw6pvg5BE=
X-Received: by 2002:a25:cc51:: with SMTP id l78mr3285579ybf.496.1606831257874;
 Tue, 01 Dec 2020 06:00:57 -0800 (PST)
MIME-Version: 1.0
From:   James Courtier-Dutton <james.dutton@gmail.com>
Date:   Tue, 1 Dec 2020 14:00:21 +0000
Message-ID: <CAAMvbhFCX5B124V26HzKziJpzMjoYzvhvjTgxeMiauoydGhycg@mail.gmail.com>
Subject: problem with btrfs snapshot delete
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I do:
btrfs subvolume list /foldername

This is a mounted external disk in folder /foldername

ID 257 gen 3455989 top level 5 path @
ID 258 gen 3455995 top level 5 path @home
ID 15214 gen 2317920 top level 5 path @apt-snapshot-2018-08-20_20:37:56
ID 15296 gen 2317920 top level 5 path @apt-snapshot-2018-08-22_11:18:45
ID 15297 gen 2317920 top level 5 path @apt-snapshot-2018-08-22_11:32:41
ID 15398 gen 2317920 top level 5 path @apt-snapshot-2018-08-23_21:11:42

I try
btrfs subvolume delete @apt-snapshot-2018-08-23_21:11:42
but no luck.
I don't understand. If the "btrfs subvolume list" has an option for
path, why doesn't the btrfs subvolume delete?
It seems that the
btrfs subvolume delete @apt-snapshot-2018-08-23_21:11:42
is only looking for subvolumes on root and not a within a folder or
external disk.

Can anybody help me with deleting an apt-snapshot that is on an
external disk, and thus not mounted as /   ?
