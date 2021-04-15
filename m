Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF563612F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 21:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbhDOThN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 15:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbhDOThN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 15:37:13 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FD0C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 12:36:49 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id k25so25403812iob.6
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 12:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=I36x7Mml0wcr45Cy7LlPer7Xgx6ETeLHeujpnqApbfQ=;
        b=TNYNoq/22TWClFbV60nzub8ZNYA4WGPylYT1yn7oi9S1mPLh4KLjCiy9GXveGvtrdU
         u+E22beKPmRI4Kh+lcVkMw7TcVgHl/SdsHmj3gAXuq0t1/qMVqypYteKD+324raKKXJ5
         +4Ut3jnlaLSHHli8lgGwK5lpNBKtFmsgg25qgRwmLD95vQcdMDMr/bKJVTywYl6SDjrO
         KcZNMJAOH1ncU4Ie7iDJ3ugAcLnjlWoHWVBrb+SZKJ1IucurK2+ntuLrL4iU/S2pFuuW
         ASZ+v+66rI/NnT9WF+UXFikD7grROdcFgMZEqg3KR1l6+w2K5IAtKRLuNHVysHlWZmg2
         iCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=I36x7Mml0wcr45Cy7LlPer7Xgx6ETeLHeujpnqApbfQ=;
        b=KXkDXGDySxRsSEjY4ZYvOcahsbXnR88nDVr1Y5YDYlqtjNoYxKVUbnvqJKAl3HRevt
         PnwI8OAaolyKSw8eq+oGEEN0HPXjeaWakSISSyAOD90eLODfbDr71tZsRND+vpOI8wHB
         aw7e0aCgqD4FPQ/+g5LEADtuyWUD+9XrCi+cylADhrYJhaIscmudfL/YgnkmV7T5C8BL
         091sExlDlwE1MgdUQ65rXR0AgVTOR2OBloiJHBty2xv7r2VnFbrQpaaIV0REDRnacT+Z
         H0nWfQR+yGXK2iKMIUNiuLciBeKETAn9+dy49msA0yw9DzJhFm1rblCyJchFE86u+23A
         gUrg==
X-Gm-Message-State: AOAM531DbiNJyqokjLX5kn0A/uLZzwodZ3HK/1J4DfPzH8sXifhpzrKb
        c/pA66Eyk/KsFq3/ub9YQ5S224FqkTk13UVXwCHtID7xadILfQ==
X-Google-Smtp-Source: ABdhPJwA/2Hp48Ds00NuvGHuX/BOB8iMBuiTaLV4QYYG8pqeG1ZmCVAVwWVTBL4xPqnmONz1qzQDbEPbY0CJ2+5H6Kg=
X-Received: by 2002:a6b:6308:: with SMTP id p8mr676883iog.172.1618515409107;
 Thu, 15 Apr 2021 12:36:49 -0700 (PDT)
MIME-Version: 1.0
From:   Charles Zeitler <cfzeitler@gmail.com>
Date:   Thu, 15 Apr 2021 14:36:37 -0500
Message-ID: <CAB9fVVG=8qLX2g=p04Oc0dPqr4EgOf_a3oSHFgCDc_jHgeTtHQ@mail.gmail.com>
Subject: moving disks to new case
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

disks are raid5, i don't know which are /dev/sdb /dev/sdc etc.
is this going to be an issue?

charles zeitler
-- 
 The Perfect Is The Enemy Of
 The Good Enough
