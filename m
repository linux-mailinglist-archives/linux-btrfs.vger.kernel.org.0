Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93AD813711F
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 16:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgAJP0B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 10:26:01 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41521 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgAJP0B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 10:26:01 -0500
Received: by mail-qk1-f193.google.com with SMTP id x129so2145877qke.8
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 07:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wWAOQS9ApRbpsDnOFQ2cbAY/DqbCLk5mhv3ua69boBw=;
        b=I7k7hbkrh+6EZbEd6NX3B10YjJCu+10Kz7Cp4lC25adRsopKYs1mqJd/BwE34XwNBT
         y9YLNEv8xUaJabHDRaWMhZlQcQbLjL1IKF6wsBhXEVMky4B+xz6+vn2nqa4Kvx0otKw9
         JyKs+hVJB811nf7Dn6e3yRJ79EYlXs64ZrW9IkuPLp61ICDTFHIiAOHYyxFT5fKP0AIL
         K8uCQGM3/hqIQ6anA+zCx6eRdyAan2u3w/e8gxOUKifY38kWA8+M3JhEotjW/vMu0KOM
         /pR+kTCvEr1vm2Mma0g/w23cbmyubORc7gudQVBmrIHxOFRdDvdwLMVDqvO0r+O+dWV1
         37aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wWAOQS9ApRbpsDnOFQ2cbAY/DqbCLk5mhv3ua69boBw=;
        b=c8BCICXIFptJe48r60vrtPovQio4ZjYG4/PmIYQ8bEUzswz+h8DsRiv4UNYJ+CijmC
         eEvEcSyA0hmDBSHtZVcItVQJXpWo0OAdky20pOBf+kyJ7PIztwXY6Y5N/MsrysTTAlK/
         811IZ5SOVoE3/Pkw291Ig/0OapChvbiYVIQuJCJDIJVgCm0ip7pZE+bIiYDtCE7sfQQq
         Qbn+mUw3HmBY8pL9ZSLdEImGPCimQj/wrSXfOpAnEzBmbmFy0fYTqH11XatqqczXCyzN
         SuBbpfokApvenhsLI+piBRdfz4AG+nyEa4D4AhPAhr9wtu3roELH0DYh94sIsrJTIv8M
         2n+w==
X-Gm-Message-State: APjAAAV1VZU5SDaL7JWPPYqmvDzxkU6w3OceOgly0O95/JJEY3/bSVGZ
        jlSNLFO0BwY7XbzjAw9J6h3ZZA==
X-Google-Smtp-Source: APXvYqwxDhvr0prKMJ5pVLPervKFWUHj2wwuqilvmMMKZ2F5AmLLnhR/EfaPRwy3KxGu4oOCFhQ3wA==
X-Received: by 2002:a37:a4cf:: with SMTP id n198mr3637983qke.483.1578669960648;
        Fri, 10 Jan 2020 07:26:00 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4dc2])
        by smtp.gmail.com with ESMTPSA id b81sm981919qkc.135.2020.01.10.07.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 07:25:59 -0800 (PST)
Subject: Re: [PATCH 2/4] btrfs: Factor out metadata_uuid code from find_fsid.
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
References: <20200110121135.7386-1-nborisov@suse.com>
 <20200110121135.7386-3-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <58440487-7a3a-a97e-e218-0cab24060255@toxicpanda.com>
Date:   Fri, 10 Jan 2020 10:25:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110121135.7386-3-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/10/20 7:11 AM, Nikolay Borisov wrote:
> From: Su Yue <Damenly_Su@gmx.com>
> 
> find_fsid became rather hairy with the introduction of metadata uuid
> changing feature. Alleviate this by factoring out the metadata uuid
> specific code in a dedicated function which deals with finding
> correct fsid for a device with changed uuid.
> 
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
