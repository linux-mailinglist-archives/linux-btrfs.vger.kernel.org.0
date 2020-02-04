Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5778151C3D
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 15:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgBDOcr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 09:32:47 -0500
Received: from mail-qv1-f51.google.com ([209.85.219.51]:41131 "EHLO
        mail-qv1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbgBDOcr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 09:32:47 -0500
Received: by mail-qv1-f51.google.com with SMTP id s7so8623733qvn.8
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 06:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6z8rBezHxXQND/LTEKRlYt4pCZiskv5qHBjHkE8GOFw=;
        b=ISN8GYhFvjZPpZ2bo5bfcYC6cXHOWr0aeKvtnjvX33QYu+oDVd/TE94Urmp9gXwM42
         +0GthFsc5/0WbfnpYJlIkj8Z/wlKEugAY+IAXp9v7hPnEtd2lE2UXjZKsxpV8TDBazOj
         vI/5MInqX985xb3aVlh1I+ucpnMiobxJo9ELwuuWUtS6tgxt0OirRkTYUchyS7uKa3+6
         J1Ao6qKbe9Key+Ez/YfOp3nqdlv5ZZ5fYZ50GZXE243GsAgKAUv3eq8veguCUWaY9M/s
         M+iPlRilx4j1e8WOBbaeUtRZU/vpcUdKA3nbAmkDsmFICmJr+5UnvmNXYz1ufEn+dV3z
         fGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6z8rBezHxXQND/LTEKRlYt4pCZiskv5qHBjHkE8GOFw=;
        b=d4o4cPYipjqIJAnOD+H9hwopuwD0ND5EhTE1JviRmSH+8IPXsccTTtdBYtE+KignXC
         LvPF3ExphiSZOK0dbErobTJvowuBWZ+jw3S9XYyuuBcNkbTaaYPsbHE8SqaoMdbAK8bl
         OkU+1VVHBaFJMklwo3F9r13N8CHcy7kVXVTbNEl+098+nEsSnVqd9f3VGcSJyxPPVMWc
         ZrbFAKYD/NWfSKuj33cZSY95YcjPi3Rgw8cf6xIJSOCCtrZOkEtd8/aO29iaiEoUS/pr
         Udcpp54D4tX6S2U86fOrnWlwy2wWELD24aewRUz1Wi9z8nZKDAvpaUA5s1xwTIozQqBA
         gwmQ==
X-Gm-Message-State: APjAAAU4N/Ktu9zl2RFF5kmNArkjEkrPtA0/bKkxei/mwREbGNYOgEPk
        wZrK23i7j6L+1cM+ewupfdG+11aqSxPE5A==
X-Google-Smtp-Source: APXvYqwTZddOVXRuWV8FkCLXGYHSKH7DX0at2s1OflBmXMYP0we5enV6l/FW16aacdwm88lKVKkl8w==
X-Received: by 2002:a05:6214:1874:: with SMTP id eh20mr28408568qvb.122.1580826765813;
        Tue, 04 Feb 2020 06:32:45 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 4sm11243563qki.51.2020.02.04.06.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 06:32:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3][v2] Fix btrfs check handling of missing file extents
Date:   Tue,  4 Feb 2020 09:32:39 -0500
Message-Id: <20200204143243.696500-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- While running full xfstests with the new progs I noticed failures for tests
  that should have been fine.  Turns out our check will not wander down shared
  blocks, instead it'll merge inode records, which makes setting the
  rec->extent_start to key.offset very important.  So instead fix the problem by
  checking for the start gap once we're done doing all the merging.
- Added a third patch to make the hole error message actually correct when we
  have a gap at the beginning.

--------------- Original message ------------------

While adding an xfstest for the missing file extent problem I fixed with the
series

  btrfs: fix hole corruption issue with !NO_HOLES

I was failing to fail my test without my patches, despite the file system being
actually wrong.

It turns out because the normal check mode sets its expected start to the first
file extent it finds, instead of 0.  This means it misses any gaps between 0 and
the first file extent item in the inode.

The lowmem check does not have this issue, instead it doesn't take into account
the isize of the inode, so improperly fails when we have a gap but that is
outside of the isize.  I fixed this as well.

With these patches we're able to properly find another set of corruptions, and
now my xfstest acts sanely.  Thanks,

Josef

