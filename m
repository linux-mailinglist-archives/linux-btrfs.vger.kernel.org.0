Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E784B99EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 08:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiBQHgc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Feb 2022 02:36:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiBQHgb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Feb 2022 02:36:31 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935092A22B4
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 23:36:17 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so3302113wmq.3
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 23:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:from:to:mime-version
         :content-transfer-encoding;
        bh=RL0jJb9jrfXXB8tmDB8ZlZ0uhKsx278EW3xNAA6/5Is=;
        b=f6Wp6zXJjXzUMKT+ihPs0pce+qjfALyc3xV0MOgHEHqHquyRvKr5BbitVnsjAsYdNf
         KGeofO4FvpxyXyqmEIZj/IHQz57tCx6apA14YGfSbvZ6Wxx0Zrtgup/Ih51Ti6MmlVA6
         bfEaVbRUveM45NAR9WnBpb/VdoIvVnxVSAJee+5ZRU9n+ahT4lbAe1mIYruoHSX8o5M8
         ZtcV4fklgH2hsydbZRRoEXmdU3SwJMiaazuMH9Tudus8HqbeWIq4+N4PHqw60+fy7aIh
         xJtr83OavGmzaYQ+CW1ZOeDoWhIr6k15C/3Woha99cQtBdlD5Oo8CPz94ULMYqyiSm8M
         s+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:subject:from:to:mime-version
         :content-transfer-encoding;
        bh=RL0jJb9jrfXXB8tmDB8ZlZ0uhKsx278EW3xNAA6/5Is=;
        b=V/1RHd/P2Yng82k/oWAPqtLh1YRehB/+L5Ru51LNqkYltI/n+OkKeA4kYDmv6X4Mq8
         mnvAEQe7TQYWukNwvo0gJi1kBl92mw41SNnJKWpcQ8HLTC+SY8yPyJNN1aWewu/VMmrq
         4OY8gWvqOQrYFRKAjB4w0F6iD0YhofQ9SlUkxhxdpea0MorwH2HmMu4VOIlvh6cmV8rz
         bzTwKewCEOKNnQGRhZBJXpz+esej3aERZlEDeqUCaZfS9Qs5nxxZfHlP5tHEeG1wO8km
         +wCY83HDpyJ/y7nXQfKs8iWBo5gEH2ZILDyf0OR3zwEjHGRAS9h8T4z/qAUIcQyvs0pV
         Od6A==
X-Gm-Message-State: AOAM531JBC7E9emuufEsGcBhuna4bRZyFxjds6+25XJtjXpFwq32eQOb
        HkPL+DANb4aMWWe3JVcUZgf7ANbaVg==
X-Google-Smtp-Source: ABdhPJzC1XaFy/hLK8J01S+GO8FguMXC0jmQ9o751YspGSPSLgJL29Sc3jXaQdn1REYpRKDt/Thqgg==
X-Received: by 2002:a7b:cd87:0:b0:37b:b8a8:2d28 with SMTP id y7-20020a7bcd87000000b0037bb8a82d28mr1412182wmj.176.1645083375985;
        Wed, 16 Feb 2022 23:36:15 -0800 (PST)
Received: from [127.0.0.1] (178.115.43.46.wireless.dyn.drei.com. [178.115.43.46])
        by smtp.gmail.com with ESMTPSA id p2sm321240wmc.33.2022.02.16.23.36.14
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Feb 2022 23:36:14 -0800 (PST)
Message-ID: <7572a64e5e840d4791930a10af58d8af@swift.generated>
Date:   Thu, 17 Feb 2022 08:36:08 +0100
Subject: AW: optcall.de
From:   Thomas Jung <thomasjung49tj@gmail.com>
To:     "" <linux-btrfs@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Verehrte Damen und Herren

optcall.de wird ab sofort angeboten.

Ic=
h freue mich auf Ihre Antwort!

Mit lieben Gr=C3=BC=C3=9Fen

Thomas=
 Jung

____________________________________________________
