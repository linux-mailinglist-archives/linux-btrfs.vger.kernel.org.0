Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9474E779C41
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Aug 2023 03:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjHLBaR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 21:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjHLBaQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 21:30:16 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4EE2694
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 18:30:16 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso40169831fa.1
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 18:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691803814; x=1692408614;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6jT+ewKJOcPVmtyZtFOhWTOaXyBD6zZEkLAVxwAhZg=;
        b=rNfEua+Usj8fXGafSoBJD1O1rRnUBKbTOGyvC14jrmvOH04CkTpm0fqWODrBFgwC9G
         iLRrxQH773NymczTlYhYSde2802yYuS//AFVhfCV9qtrw6n5ZimXYdw7xOr2mhZ4LMiZ
         ArTmSHwnjBrCOpL2JOrgONGmAykXdw/RjzScpj1l1/4W4bQvo9geu6rVahce1MNtPA/x
         /0Ji4Lwh6aC8/mJSaSHaQj3z6/ciIQVs3Sl2W6yH+0Y4r3LOQdlj7TbSVsj8djzWW6U1
         9DScm41EoeaFpsmUT3ZcpPxufEbD9oZiu+VdoV0Yxq1/WCJSe5r1l54O/YNR5viThT+c
         hLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691803814; x=1692408614;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6jT+ewKJOcPVmtyZtFOhWTOaXyBD6zZEkLAVxwAhZg=;
        b=U+Yiey1DzOqgpX4BZb2vDzW9EkXeG/p6M8plO0W50t2BkgMDD+o8ijJpY1JN+bRkdd
         RkGr/R+l85jf0vIZjBuVKHoZIx5VyxOze6q6x5lJIF+tajkVAhyzhBX1mm77soLzgqwF
         NIh2bhRE9aP49HZSbfgD11/SfRlLXj0EMchoQiyld1QGDa2C1XdFqMWgjdUMwafj++um
         voIGD4aDAZxTH75LacnU8YAoW7yHIe4zzTLM3pzcZJZTIF6sDFIcMXbfzJXj861eFtuL
         H//L4XH1gfNOej0agRcYkuc50zqeCOdRkEnZ1z2v5No1yVmEz/wGGmJP4SKsqDw1j5Ds
         NsRw==
X-Gm-Message-State: AOJu0YxpU2Slr3PiihAnop+GqdXtfHa7OM+FczqIW+Mx0pu7Mi+IDlLZ
        xQga6QL/rZJStW+xR6ezu8z11NsCqi396PgXaSU=
X-Google-Smtp-Source: AGHT+IHjOXguzKZzsgn/LlxweSAm+fVpquoj0+pwTpgLgTGH9nHjoFgqYUQYko4CPFROT28i8YibjPJyFV14jsfzoYI=
X-Received: by 2002:a2e:90d4:0:b0:2b9:ac48:d7f5 with SMTP id
 o20-20020a2e90d4000000b002b9ac48d7f5mr2915471ljg.39.1691803813989; Fri, 11
 Aug 2023 18:30:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6022:54f:b0:42:f87c:1d86 with HTTP; Fri, 11 Aug 2023
 18:30:13 -0700 (PDT)
Reply-To: anijones76@gmail.com
From:   Anita J Hester <lt.col.anigretzinger@gmail.com>
Date:   Sat, 12 Aug 2023 03:30:13 +0200
Message-ID: <CA+eGYSeK8mNg02bCCT1R8oVdTUEqRf_8JsoBy-aP-NmbHbjA1A@mail.gmail.com>
Subject: re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Greetings I am Capt Anita Hester  I contact you for a contract that I
want to share with you answer me via my private email
anijones76@gmail.com
Thanks
Capt A Hester
