Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8D745A667
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 16:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbhKWPWp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 10:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbhKWPWo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 10:22:44 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06871C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Nov 2021 07:19:36 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a18so3011078wrn.6
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Nov 2021 07:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:from:to:mime-version
         :content-transfer-encoding;
        bh=aUKTKJueGjekIJX4N8CwRUG0tWgYml8qx2eY+Zx2pfI=;
        b=mjQuvCn8AscQkUKw0NzJwDEjiMW3TBljWgD86eTL39sqt2NQrWebfOYdt/ywJFqk60
         UizCYiWRCNVxoeX2kLZb/cZQxl+Mgw/sfX3HCNFQ3GQJ4m1LNXWmL9zEhuxj2OXNiNGY
         C16idECdpo+SKjuIG7MxRCAtDf+zN0XUn9Q15klzbMTL86GfFqRtID3sb5laOIwXSsbC
         A3ifoobmKqL2i4gaT8uB24xuskAJDtGK4QC3ygyipVwyKxnsK1MYGH3hRRPqMiH3i8Tr
         ju4Wp05fhjxOu8gnlsFTYqw6Gm5B+SljgaihxZhgSEFQpHzV5uWKg73eVoi37fbIEgkf
         k4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:subject:from:to:mime-version
         :content-transfer-encoding;
        bh=aUKTKJueGjekIJX4N8CwRUG0tWgYml8qx2eY+Zx2pfI=;
        b=MwxzMTM3TYuSQ8HUU06yUV5MSEpp10ICNs4toazGD7DGSRmnPufwaZ/Cx9TnnBAEL3
         AYjkcQwhaqdrrbC+sM8+lgoU7SzXSZLqk5Z56na0OtvGYgdqF/ptK7Lr0oHgbHmgVkeK
         LKvFn7WpVJ3x05+Xg4CWLNtsq1dkqGYx1Hyw2vo7Idrzh/5fP3BOffGLSnXAssHMFoud
         Z/tSZC4eTJ8rT19A6rve5UALVz2lnKb6whMrvgl9GbZfyS0yYLY6lQvIE28KIKn5XLQb
         /lYWRWm59ykHTTGAmWEdDXhI9A/0/4QDaNMfNxVanrZsxQhaicrdnt7jBu3jv8kvD70n
         VUOg==
X-Gm-Message-State: AOAM530oYxCn3iZ81iT6DikeeeVe2R8zuVwmfPGQz2z2dGuTXJrKiaQF
        HucV8tXw9kP2KbQZQpZxCsvF0NWp+U4=
X-Google-Smtp-Source: ABdhPJzEl4kE728qKaAIMMWzEMFxfpcyIf5fz2kzF996X1FwBCcTGEElzKdWCuOVE1ApjEfq828PRg==
X-Received: by 2002:adf:ec45:: with SMTP id w5mr8111536wrn.183.1637680774675;
        Tue, 23 Nov 2021 07:19:34 -0800 (PST)
Received: from [127.0.0.1] (178.115.63.85.wireless.dyn.drei.com. [178.115.63.85])
        by smtp.gmail.com with ESMTPSA id o10sm15348206wri.15.2021.11.23.07.19.33
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 07:19:34 -0800 (PST)
Message-ID: <2de69a2dfea543f486c844ee6e13475a@swift.generated>
Date:   Tue, 23 Nov 2021 16:18:52 +0100
Subject: AW: Domainname linux-engineering.de
From:   Hans Weis <whans5002@gmail.com>
To:     "" <linux-btrfs@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sehr geehrte Damen und Herren!


Ich dachte mir, ob Sie vielleicht an=
 meiner linux-engineering.de interessiert sind.

Ich freue mich auf Ihr=
e R=C3=BCckmeldung

Liebe Gr=C3=BC=C3=9Fe

Hans Weis


______=
_________________________________________
