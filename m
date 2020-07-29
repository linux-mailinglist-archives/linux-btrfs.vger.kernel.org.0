Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A01231E62
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 14:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgG2MRv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 08:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2MRu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 08:17:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23C0C061794
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 05:17:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 184so2744381wmb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 05:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=GPG/7S2wtzbOqoyTwiz/aMQdD5bUHTr9/Sxt7J+EHCo=;
        b=Us45wV90PARoIddtdxH9raTf3sLVDyEZlBws3w7cKxnScvr7nrpTqvLpmL6o8YihsM
         Jfzows0NbVyYlVfjFxSExUngUpVRwGG8TOfwSLpoaXyEGuTfPbQp8JPMK4+Yj0+qTVHg
         VqDC5D8umeW3TMME98s6ZgG3/7kAbQLOZvWHFLujEPc0UwPI8jvelAJLdMCB2g/uCWeH
         RRMSpmXmXDppHQxo17FOseo4xXoV0ZAfvDPaRM/zy5jG+d5Z0NzovN8MOLVe4g6nVQEf
         5TdhcROkVoMGcc/CpiOfJj3MNIkdRkOXSnaAkkv/gfsjmHzNg4kSIj7iry15M6l/kT0G
         8+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GPG/7S2wtzbOqoyTwiz/aMQdD5bUHTr9/Sxt7J+EHCo=;
        b=DUuiVv45SakzXIkSaT/HvlWyXhMDyHZ5qPE/igrC1L5RT89yNXFc2nFbMh1HnCwdwF
         sAHGrI00eY8W9lQk+TViUQql8qZIQkkDyWggXeLJi6C+u6BWbMUWFiPRrai50qVf+F43
         ZPS70/dUalUN5WIy4u3Gx3dHXbvNLAa2U0NWJ+RfHfITOAy7fqpVeRhmqq5Ejizqj8of
         pE6aa6NvPyFQuQBckiXPzMd75H9+DHkqE7wIt70F8+UG41Y6XNjxWxlFGcD4W/y4qp6Y
         sd6SS8spFwdwz8j2GSobmZlZPgCbRmCPUrVFSSXwE4vSKl049HzmWsC+FYlUc/oD1CHk
         caHw==
X-Gm-Message-State: AOAM532VU+oIc43ZhwGmVnKknvBP1+Vfezxlv4w+M+7jtnAws6DjIBni
        kHilDnoj/3SGaa7HnIlU85j0c9qw
X-Google-Smtp-Source: ABdhPJzbo/o5quOE/vvZ7c5E8siJBktdv7ZsUCru8LS7uR3O/hokf/sy3GBRKjcOPHKNnOhBcgNmKA==
X-Received: by 2002:a1c:1f12:: with SMTP id f18mr9017094wmf.66.1596025067468;
        Wed, 29 Jul 2020 05:17:47 -0700 (PDT)
Received: from [192.168.111.113] (host-2-114-69-218.business.telecomitalia.it. [2.114.69.218])
        by smtp.gmail.com with ESMTPSA id s203sm4848782wms.32.2020.07.29.05.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 05:17:46 -0700 (PDT)
Subject: Re: using btrfs subvolume as a write once read many medium
To:     spaarder <spaarder@hotmail.nl>, linux-btrfs@vger.kernel.org
References: <VI1PR02MB58697B26A91E68507032D9CDAE700@VI1PR02MB5869.eurprd02.prod.outlook.com>
From:   Alberto Bursi <bobafetthotmail@gmail.com>
Message-ID: <66867d3a-7dbc-7d3a-1883-29c1f0cb510a@gmail.com>
Date:   Wed, 29 Jul 2020 14:18:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <VI1PR02MB58697B26A91E68507032D9CDAE700@VI1PR02MB5869.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 29/07/20 09:02, spaarder wrote:
> Hello,
>
> With all the ransomware attacks I am looking for a "write once read
> many" (WORM) solution, so that if an attacker manages to get root
> access on my backup server, it would be impossible for him to
> delete/encrypt my backups.

The only way protect them from an user with root privilege is to move 
the backups off that server alltogether, as root can simply erase or 
encrypt the raw block device, and the filesystem really cannot do much 
about that even if it could be set as permanently readonly.

So, keep a NAS as a dedicated backup server (i.e. that's the only job, 
to limit the ways someone can get into it).

Then you should limit what an external request can do in the backup 
server application/script/whatever settings, so that it will accept a 
new backup or an incremental backup from a client, but it will not 
accept a request to delete a backup.

And obviously have more than one backup, possibly off-site.

-Alberto

