Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11AA910A90F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 04:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfK0DaS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 22:30:18 -0500
Received: from mail-il1-f180.google.com ([209.85.166.180]:37116 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfK0DaS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 22:30:18 -0500
Received: by mail-il1-f180.google.com with SMTP id t9so64131iln.4
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2019 19:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=k7xOk6wkDGBtNypYi8P+8/ASKaX1BZXclyMO3zaMj0A=;
        b=IxwjIQRLXIwZpgIdu5f+Z2ANuUJJH1ZvDZ+nzjmUIAtsFM1OuUAXAYaGJB90rJG7R6
         lu7IEdGnEQKxL0TtoKR/2UpWpIUHMtXnNRk0uOxZ7/PdZvNGmXRpDlSPgFGyMhwQXT/1
         GW4faNcGcPSgreDofx7VzoFveBZiCk3Es2KQlCiEP1NsiKciyHa97AlFwk0bnmwtg4qZ
         TPXi/ppgEzTmFk0l+HCflTHtqvTu26SMLtIO1dnaTD3VI//Z2aEvrXx5rH6SOQF2yvpd
         fk7SDR7tQ6NrB5gYSf/PLTvdQXwTv9yaK1m8nAbTHSQlTe3XjQXgnlTKDXHOLMaIB75/
         dOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=k7xOk6wkDGBtNypYi8P+8/ASKaX1BZXclyMO3zaMj0A=;
        b=kwg5HDMFdSAQDW35SwrmQ8YxvTlITgsJf32URzcjr1wIfeqGhil26TyTIfln9Ff3d+
         53e5c5O9fxE5u7idU4hTuB/lSAJZqQ38kGNxs8MQWkNJ1WF96nvmkQH6yrgKZqR/NyK6
         qTAezioBj3t9H6o8SGzW6wN2rQ2jEUOk5h5HctEkKK3E18w8K8ytRgWv9t85pLrHvjQP
         QmuF4iBTXubRvIZj2XQKh4Ps3jIi2rl60kCPqrjLCoUV3gDh8nCOVgxUe7eBnGFh/P7G
         FCscMq+eC+gi1HNzJUVAjx+rk8uZ47p9rYRnJ9JyXdrFI/7gkPBODlS/oyrCP/PtqpnV
         u0lw==
X-Gm-Message-State: APjAAAXvmY4FPdRktt5K6MlVVNc2i7rP6ZLV2UcVszr4WOM0sjC1Ebqb
        vwddkjHG2Y2eFME8FmPHdIV4G9OW0VmAXmc4jcbcKOLb
X-Google-Smtp-Source: APXvYqy9gHn+DGu+MObJNwNt+0w9bluEwDxXzJY9Mk7xxHkh12EMC5yg4/U8B5nVSNoJ3mPZAE9F8d9MB8znuVX3Lsk=
X-Received: by 2002:a92:1a11:: with SMTP id a17mr44686594ila.232.1574825415709;
 Tue, 26 Nov 2019 19:30:15 -0800 (PST)
MIME-Version: 1.0
From:   Christopher Staples <mastercatz@gmail.com>
Date:   Wed, 27 Nov 2019 13:30:04 +1000
Message-ID: <CAGsZeXsEZ8EqPsuU9O+7d+suxBVNQAobASJaLNMZB9LhUe6Q7A@mail.gmail.com>
Subject: bad sector / bad block support
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

will their ever be a better way to handle bad sectors ?  I keep
getting silent corruption from random bad sectors
scrubs keep passing with out showing any errors , but if I do a
ddrescue backup to a new drive I find the bad sectors


the only thing I can do for now is mark I/O error files as bad buy
renaming them and make another file copy onto the file system ,


I like btrfs for the snapshot ability , but when it comes to keeping
data safe ext4 seems better ? at least it looks for bad sectors and
marks them , btrfs just seems to write and assumes its written ..
