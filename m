Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBEE4A9EE2
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 19:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377507AbiBDSWK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 13:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351887AbiBDSWK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 13:22:10 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A6C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 10:22:09 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id y3so1018459ejf.2
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Feb 2022 10:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IgAZJVrE/JPNB+PhIz66Ly7FjU4cFDkmy51eoaPrqkI=;
        b=d9A02hJJ36scnGKvs7jqHHYemSQQwa55qR3iKOuuCeed+XlFTcadYvRp3LE/TWmlf1
         9XCxVSUkRsj5CglaXYO2u7hFqTWKk30fiEmBpiuou62FPdOzdH4VDQK3e/u5MuzfFYuN
         G/xpeT5nXr5YX5yXbj8HdRo7TZYsr7lin+ZKNoRo6L/MkgRKfbTZhV6uGgGmc4BcAYrV
         dxJzRQlKNu0sRhk6uv24Mlt+mue/UyXO7afaBUZZn2sHJPuLz4aWZYdU4/W0kG28+Z7n
         mEb3Y9Ga/ez2gbccv7jUI3yCVkN5Rd3Khq1chyAIiWhcEGbdVTct3I2CeMIUJRgjHQZF
         2tEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IgAZJVrE/JPNB+PhIz66Ly7FjU4cFDkmy51eoaPrqkI=;
        b=DCRKaYTNWsklkUcTW4JEol5lmn/ubthMuzNPF0elvja98giyOgttxc/ulrBbA0QdQl
         ikbwNDzhFY7cH73dsse6YnMy0Ueki+z+XI7QdjmR9oHZR8cAijTStZWGvpMv3YN3D/In
         v8O5heUJSg+6dACOyS3TXNiHtOlezzQtsE859umw0rlgBCTQa3RxCegTrOPPKiVthA7F
         SLCabw+gN1NlAqr3f9YrpaZGxOnn7v5MVRO+F5pGPkY14GuECYcI6jIda+2Zt2095uYw
         xkJOjpy/kxQkATfbTbOk9/SDHzHmQaIk8bfv8UKAJJLvWqNSQSrs/fgPM0zqm2/IrleE
         Siyg==
X-Gm-Message-State: AOAM531T0Jx03lNUt7RE5dPlAgPUadVBJjp9Ukyh6AHFlIZRjuI4xjY7
        ftpS5NuUzjk4ntb0QZqQcYQ4f5xr+OWURw==
X-Google-Smtp-Source: ABdhPJwWz/7SLpPMDAwdqHfN5HtkmIAW1oxzCsRViywMUvU1GLABwmtUyWQSBloxiL81XU8ViuUg3Q==
X-Received: by 2002:a17:906:4fd6:: with SMTP id i22mr146514ejw.502.1643998928072;
        Fri, 04 Feb 2022 10:22:08 -0800 (PST)
Received: from slackdom.home ([151.53.183.194])
        by smtp.gmail.com with ESMTPSA id s1sm1148560edt.49.2022.02.04.10.22.07
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 10:22:07 -0800 (PST)
From:   Domenico Panella <pandom79@gmail.com>
To:     BTRFS <linux-btrfs@vger.kernel.org>
Subject: Btrfs boot message
Date:   Fri, 04 Feb 2022 19:22:06 +0100
Message-ID: <4507791.vXUDI8C0e8@slackdom.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I get the following message when the machine boots up :

"mknod: /dev/btrfs-control file exists"

How could I remove it?

Regards


