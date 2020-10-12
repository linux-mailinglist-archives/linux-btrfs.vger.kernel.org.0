Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D3428B3D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Oct 2020 13:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbgJLLd5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 07:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387617AbgJLLd5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 07:33:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB6BC0613CE
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Oct 2020 04:33:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v12so1754528ply.12
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Oct 2020 04:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=LQb25rjSWbC3PuGd6zv6QO2qRPm6z0zKMm5447zonXg=;
        b=PWr2KIVj68oEqj0lgV0QAIDyZ2eog390B1OBPgeyEvPu8rDKJ4NOVZQlZ94ahHgJbN
         W5yJHervAnOSZZTwOmelDzyqBWlRRbSLwztEM/PqoR3kIN/6J8sX6zOQl2r3pn55Xv+n
         AcrL7lV0qHAtM7KJY1ypiNluEGDkHIhWxUNMxSGGWzW0wEx/anW/s+w9b2htfNgEfN45
         U72nsmzuoQP9upZr5rcRx85gYndgbTaQdut9oni3RlZdrWifAkdbbRQcFOBvrk4dYbt0
         sWALO0JINvFwohB0lwf7/jSNi6qdyg9cRXglJPkIDua+KGK2j1x9zL+IfyRbubWfJnCA
         cy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=LQb25rjSWbC3PuGd6zv6QO2qRPm6z0zKMm5447zonXg=;
        b=YyNP+Req6pVwTH8/ipqfOzsHTBnfqdClof/FSjtzp+OB0gAsBHL9wXrHYioMfv+gVI
         +u+jU8PDQVrb/WVdeRMeYixJtkGQPCQK7goUz7daNs2agV/f8RLc9Qb+Kazoh/ydPeKa
         v8BRIwBPIAoluKlaGKaqv5tRkz5H1mvA4jZnW97oaETEb6SG+lS2eiwcfbzFPMuGrT1X
         dQzn2bKBtrN2rM2aCkQR6eNVHpvXaaWg0SWisr9r4Fa4arTFamoUhUUai4CNmMZTvdBa
         +5BxIOovOta23vPOqo2IZpISP21bbIL7c0/7swk5kT7/xdqXcIMNOUHZ6R5pLS+ACRHs
         LMZw==
X-Gm-Message-State: AOAM531Ab9sMozYzkdA9z0nrKLsCI+ug/1v+gtUUt1nglDf6L2cKbkUa
        ZwkT1bmisSX/wI1tjIhccD+xIIgjCyE=
X-Google-Smtp-Source: ABdhPJzHpLa7pIm1Dq13zSApa6cW5QDl0bNAZyxKl3yX2ZEsVZ/BWSbUXex4AsXsogBF0z+pisgVpA==
X-Received: by 2002:a17:902:be0d:b029:d2:8084:cb19 with SMTP id r13-20020a170902be0db02900d28084cb19mr23363135pls.45.1602502436564;
        Mon, 12 Oct 2020 04:33:56 -0700 (PDT)
Received: from [0.0.0.0] (tunnel595741-pt.tunnel.tserv22.tyo1.ipv6.he.net. [2001:470:23:8a4::2])
        by smtp.gmail.com with ESMTPSA id e186sm20527296pfh.60.2020.10.12.04.33.54
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 04:33:56 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [discuss] GUI for "btrfs inspect-internal"?
To:     linux-btrfs@vger.kernel.org
Message-ID: <37457d69-df20-7280-0707-c5e69dabb48d@gmail.com>
Date:   Mon, 12 Oct 2020 19:33:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello all,

I'm a learner of btrfs, I found "btrfs inspect-internal" is very useful. 
However it's seems not user friendly. For example, if I want view 
EXTENT_DATA for some inode, I need to walk through root to leaf (I'm not 
sure), which is a boring task.

I want to develop a GUI for "btrfs inspect-internal". Basically it will 
communicate with "btrfs inspect-internal" CLI using pipes.

+------------------------+
| btrfs inspect-internal |
+------------------------+
            | pipe
  +---------------------+                   +---------------+
  |    backend server   |-------------------|  web browser  |
  | maybe: python+flask |       http        |     (GUI)     |
  +---------------------+                   +---------------+


The GUI will include features like "click block offset to jump", "view 
history", "jump to inode", etc.

Do you think this is a good idea? Comments are welcome.

Thank you all!


ZBY

