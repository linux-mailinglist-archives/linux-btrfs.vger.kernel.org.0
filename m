Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3656E137112
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 16:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgAJPYH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 10:24:07 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45167 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbgAJPYG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 10:24:06 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so2111802qkl.12
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 07:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FSO9SxQcEgp6NEqQMViBPEzwIfKAMDTlmHwK3rBdSt4=;
        b=0jCEh0UnA3dCQOTMxE3aO/lVhNFl6HyXMfLJt+7weIJWK4ykMnFV9saK53IE6Mr4Kq
         LTjOqlPW0ZsSnQEJ/G+iziTok0Dds9iCsHy2GYgoF4HiQZFArcvgO2OHt0dDAg20h9Qn
         kA9Hs8U7tFt/KoR5PDrI3vFCEa1hEJ5VTCC/Q9Hv4E6j6FGPGzysftX9r8Aw5QuJu4uC
         91/IqG0VHoA5ffcKorsO9DmTmweSuZDnMxJD8VcRqI+2FY+HTzFdtprOVLbdONdHk8nw
         +bI3Jq+i3cJYtyyWl3PLBQHDAhCPdT/wtFyk3f/1E3199svs+MDsmTrKITNxXSwJ9peP
         doXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FSO9SxQcEgp6NEqQMViBPEzwIfKAMDTlmHwK3rBdSt4=;
        b=IcGsDsbLBaXfJdM20c9mCyfmxl+DrY35/F7p0DtG22qlWpCyuGtjsIKaia7BmHYkTN
         RqBAMs+FZKhCBIV5fJbCsR4lL/TrMfeM2YNKVuDW5Di6ee1daP8EQjPbDOL1WDZSztIL
         xzUswc0Oerr5l/eW3aKx/Pe4HDAzGvAUyUVxl31We1/Deds37QHAiNqSICO+CK2f/uyu
         a6iAdpQOms+7MZTiO7xDI+R1z1PJEIt6Mbnb51SLiU1FSKSpNVrLyWQEvPtbeFTcakJ9
         YgcW9EbvatuTqTLqul3LyezOBWvuNopxzCxVeuYk5ihgT8DM7feu1Q6UR2YwiP9ocIUP
         nE2w==
X-Gm-Message-State: APjAAAWctzHUSevGcl7Hxles2t32nXZvIjhZoTOht/LKKA7FX9/CZ1yP
        FMIyGD1iQao2vr6lmZeWWhjyEFLRaM2RTw==
X-Google-Smtp-Source: APXvYqyZaDyvoZaXFzZUGEOtgx1TJWkPosqoSe6Io/rvISearTV4Hc67Il7NE8OXGzDxDMkfoFntog==
X-Received: by 2002:a37:78c2:: with SMTP id t185mr3572137qkc.361.1578669845078;
        Fri, 10 Jan 2020 07:24:05 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4dc2])
        by smtp.gmail.com with ESMTPSA id s20sm978741qkg.131.2020.01.10.07.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 07:24:04 -0800 (PST)
Subject: Re: [PATCH 1/4] btrfs: Call find_fsid from find_fsid_inprogress
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
References: <20200110121135.7386-1-nborisov@suse.com>
 <20200110121135.7386-2-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b3ed490b-43d4-2be8-db0d-fe5a1d9a9ab5@toxicpanda.com>
Date:   Fri, 10 Jan 2020 10:24:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110121135.7386-2-nborisov@suse.com>
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
> Since find_fsid_inprogress should also handle the case in which an fs
> didn't change its FSID make it call find_fsid directly. This makes the
> code in device_list_add simpler by eliminating a conditional call of
> find_fsid. No functional changes.
> 
> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
