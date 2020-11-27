Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5602C687A
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Nov 2020 16:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgK0PLY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Nov 2020 10:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbgK0PLX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Nov 2020 10:11:23 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A468C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Nov 2020 07:11:23 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p22so5410418wmg.3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Nov 2020 07:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=A7KnV7YqktcRGRLt9GH/1GY5CqIcxrNTnLv25YJ2UMo=;
        b=d2JnRhl51q8FbHeTotcyZZL1axlmAmDDVkec+EItH/6+C8JTV74OkAqCGSBJIA0jXi
         AfIC1Tg+5/Vgw/LrdNVLFRO0OWx03myS6HmBLCmUWSNnYgT0CrOsslV1AGoyqWU5ae5f
         iLygP/7XLRftBjJ2uwSfbmS27C+0d/gZp0yNinyRknLUIUe0se8/OaogXc8k1CPcVdkR
         n4kWspcu4ITqCfVYJatvvL/6/dB7MFt+Hk2Tu2J0JwRKImovHKklNmrq0nDnkgkrx9l3
         pKRfIIOkNlm9olqMAuwyQPOV2AX7bR7yOTF4FP4GUDgND8j5g1iQnYxK5OlQxdL71tml
         ELlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=A7KnV7YqktcRGRLt9GH/1GY5CqIcxrNTnLv25YJ2UMo=;
        b=PxJAcuPeu4RZMthf1KpmYk8R2G8F1HnEVfIPklZqM3T0F4I0V85JeBvBEdCyhhj0cc
         sAB7xsjZw/c6eFkV+PinVj6Vp5oGbR197TVsUzGXqCOnvW73m+2sbd4EM3vHj2BQbVpU
         9M/J5606XWxY+TnIp+Vdz25SReUdXoSX1ip0lLwAdR7ftfrbrTDmW7IrhAbffgd7w5rv
         HmT1oEjSnKW31lDU6DV4NzDKpRsF19GARvLm9qwCP3Trl27VEc7PVmFXMPUTF9fMhfB0
         ehMQ4Kvvz8kjxhpDS9UtvtlufGC/sWVwZe2+iDv4Kg+v5dTzqCAhyfKWx6K166Z8NCTG
         3Q+A==
X-Gm-Message-State: AOAM530z0no9BLssVpZ+nVkGmPwrh/7v+oASlAo2AlfmCxlW6FN/JOEm
        PsU+ImgYOrkC837BdgjyuhkKDDs/Q3szqQ==
X-Google-Smtp-Source: ABdhPJxsLgDI7J96cm+gqn2IghJQyFeL5kpieFq8c8MHL+Ny/FBpJaxl1JFhL0q8IxpRitvsfqPJ2g==
X-Received: by 2002:a1c:2804:: with SMTP id o4mr9919652wmo.171.1606489880694;
        Fri, 27 Nov 2020 07:11:20 -0800 (PST)
Received: from [192.168.1.6] (dynamic-adsl-84-221-8-74.clienti.tiscali.it. [84.221.8.74])
        by smtp.gmail.com with ESMTPSA id 189sm14587796wmb.18.2020.11.27.07.11.19
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 07:11:20 -0800 (PST)
To:     linux-btrfs@vger.kernel.org
From:   Zener <zener78@gmail.com>
Subject: btrfs metadata mirroring
Message-ID: <96b1b2e0-40d6-dfa4-25bf-dda02732f30a@gmail.com>
Date:   Fri, 27 Nov 2020 16:11:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: it-IT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I have a disk with btrfs but now I'd like enable just metadata 
mirroring to understand if some error occurs.
Do I need another disk / partition / volume dedicated?
How to do?
Is it safe now or do I risk to loss my formely data?
Thank you for your support.
Bye.

