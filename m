Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFA8135C80
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 16:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbgAIPUO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 10:20:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37021 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgAIPUO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jan 2020 10:20:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so3275726wmf.2
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Jan 2020 07:20:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Ji3TGhJzDny8rGT8CoH5M2xumaxfAigUvDKGoXJlaO8=;
        b=aqTKCr6OCvuOK5W//y9E400zhoOBhXVEdeh5oQD4XT+yOjDreltSHiQQJ4I8oDQLBE
         B0vnaQFdQ5ouv9VQX+b/V7frLo53jjU2IBa8jl4/xrU9k4Lpad4Sl4K+K2qm4wacO2+n
         LbuHHxB6hne8j1LT9dU+j0gGH9yVrJa+jf8878VVn7oZTpz8AX2wtxIVOKPUNEV5Ad9t
         6kCA6zsyfa+UdEfNnjYpfCRB8o31LBnPv4QCWZKGCMY7Nx/tFJ/Pz5Gsv767/X7T/EI5
         quAnLSDL45zFC8oEc3XMi/vr0iWF+IuReyS/QfGxxt5bdDiVqLjssYQaNwgMm7sBdkn5
         EQfw==
X-Gm-Message-State: APjAAAVmt/9Wt2rp0TsI9dhdZb0+jNPDaSRUXUBYVRYTz9Z205hsFiJN
        tsl7qz8F0iz6bZ3+3VLDfo8=
X-Google-Smtp-Source: APXvYqyit/KhGbWa9NXyKzWnVcjldJQyCaMY4yd+R8yhSdbmMi8ueZCC7xcXRoedvkbe8LEH3AgEUg==
X-Received: by 2002:a7b:c750:: with SMTP id w16mr5847443wmk.46.1578583213533;
        Thu, 09 Jan 2020 07:20:13 -0800 (PST)
Received: from Johanness-MBP.fritz.box (ppp-46-244-213-229.dynamic.mnet-online.de. [46.244.213.229])
        by smtp.gmail.com with ESMTPSA id f12sm3101183wmf.28.2020.01.09.07.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 07:20:12 -0800 (PST)
Subject: Re: [PATCH] btrfs: Fix UAF during concurrent mount and device scan
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.de
References: <20200109110210.30671-1-nborisov@suse.com>
From:   Johannes Thumshirn <jth@kernel.org>
Message-ID: <3a4b59e9-0098-72d8-3b38-cb1ef2735fd4@kernel.org>
Date:   Thu, 9 Jan 2020 16:20:11 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109110210.30671-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
