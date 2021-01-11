Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BACD2F1F66
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 20:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391084AbhAKTbI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 14:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390936AbhAKTbI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 14:31:08 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAF6C061786
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 11:30:27 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id y22so145589ljn.9
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 11:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wxHqeRw56G6fHDnf62rOPgQEOr6+eXW37FOkzvA0QE0=;
        b=em4EWpg5Dtc0kICcmSYNb+v/JFtZyLDjt4v5FQGWKoRU+x+cPEgSI7Vxm78mQdIvly
         7lbZj6JzWYsenihQXRY4Yu8ZokBD/fd4UnM4MiRKojfoC0PjmwHrPtMTtdggGa2M8k18
         CjyUCZnyzzI5NzHpP2n+hNVY34HvVCcgo4134BSq2ijLXQ1QVnCysmq7JzbHrRLmZyxL
         oruTHwL51OD9Vb2m4OAPBYfjdXe0GdmieIktluoYY4Psl2b1yF5Rw/aMDlFGM+5oQXkW
         VTMchA1XkQE1ATCwIVCS/vEZDr0uf9GMJ9ZJqCFKC+u9R4rHrVwRdH2VChB3xb49raWR
         3K9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wxHqeRw56G6fHDnf62rOPgQEOr6+eXW37FOkzvA0QE0=;
        b=L6y7kmGi/+gnVh7RbJ5QoVeKuZR6Fd/dKvfUwqn/hyw13ecc06JXvLT704xvceZXKC
         1QhLwJcZ6D3CXYUYlC9A9iOhmBLLJxcQtgUK4ogw3aEybR0GvaQ7PzfHbMIlfw8w9tSN
         4ANGKioTb5VFR0UxavDR3JXDW2vQRVxP8jbOE5nhUFSEnTO+JoOyFBBvLTyjcOWkySIX
         F1JbX6kZhBqGYq/ERaloWnL2FfiL5Jvs2uavYxgo2Mhw5Z0vgOYLmO61qRfHaymVuQii
         Y7GK2o0pn4stGnKMjkNEf2g5vXzGcsBPbRWsRKqmlhVbZ8XiBVmRYxvNlOwTfxUqlqA1
         64hw==
X-Gm-Message-State: AOAM530c2Hl4vTvzagFwwjDAerrILjXJPDXzbJ46HcT4+OOKZuyANbAY
        DsjZpCNqNsWA+J5v9DSj/V03v4coI88=
X-Google-Smtp-Source: ABdhPJzeSX7P6tVe6sjrRUg2Ksn7931Okb6bmzGu85XWNOAREVDpGLsQiB2F7uQD9Eee8vrWaSmdtw==
X-Received: by 2002:a2e:7102:: with SMTP id m2mr437785ljc.245.1610393425534;
        Mon, 11 Jan 2021 11:30:25 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:ecb3:590f:aaab:50ba:573b? ([2a00:1370:812d:ecb3:590f:aaab:50ba:573b])
        by smtp.gmail.com with ESMTPSA id g4sm87515lfc.85.2021.01.11.11.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 11:30:24 -0800 (PST)
Subject: Re: [PATCH 2/2] btrfs: send: fix invalid commands for inodes with
 changed type but same gen
To:     Roman Anasal <roman.anasal@bdsu.de>, linux-btrfs@vger.kernel.org
References: <20210111190243.4152-1-roman.anasal@bdsu.de>
 <20210111190243.4152-3-roman.anasal@bdsu.de>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 mQGiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kbQmQW5kcmV5IEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT6IYAQTEQIAIAUCSXs6NQIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAAoJEEeizLraXfeMLOYAnj4ovpka+mXNzImeYCd5LqW5to8FAJ4v
 P4IW+Ic7eYXxCLM7/zm9YMUVbrQmQW5kcmVpIEJvcnplbmtvdiA8YXJ2aWRqYWFyQGdtYWls
 LmNvbT6IZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AFAliWAiQCGQEACgkQ
 R6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE21cAnRCQTXd1hTgcRHfpArEd/Rcb5+Sc
 uQENBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw15A5asua10jm5It+hxzI9jDR9/bNEKDTK
 SciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/RKKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmm
 SN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaNnwADBwQAjNvMr/KBcGsV/UvxZSm/mdpv
 UPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPRgsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YI
 FpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhYvLYfkJnc62h8hiNeM6kqYa/x0BEddu92
 ZG6IRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhdAJ48P7WDvKLQQ5MKnn2D/TI337uA/gCg
 n5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <9e177865-0408-c321-951e-ce0f3ff33389@gmail.com>
Date:   Mon, 11 Jan 2021 22:30:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210111190243.4152-3-roman.anasal@bdsu.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

11.01.2021 22:02, Roman Anasal пишет:
> When doing a send, if a new inode has the same number as an inode in the
> parent subvolume it will only be detected as to be recreated when the
> genrations differ. But with inodes in the same generation the emitted
> commands will cause the receiver to fail.
> 
> This case does not happen when doing incremental sends with snapshots
> that are kept read-only by the user all the time, but it may happen if
> - a snapshot was modified after it was created
> - the subvol used as parent was created independently from the sent subvol
> 
> Example reproducers:
> 
>   # case 1: same ino at same path
>   btrfs subvolume create subvol1
>   btrfs subvolume create subvol2
>   mkdir subvol1/a
>   touch subvol2/a

What happens in case of

echo foo > subvol1/a
echo bar > subvol2/a

?

>   btrfs property set subvol1 ro true
>   btrfs property set subvol2 ro true
>   btrfs send -p subvol1 subvol2 | btrfs receive --dump
> 
> The produced tree state here is:
>   |-- subvol1
>   |   `-- a/        (ino 257)
>   |
>   `-- subvol2
>       `-- a         (ino 257)
> 
>   Where subvol1/a/ is a directory and subvol2/a is a file with the same
>   inode number and same generation.
> 
> Example output of the receive command:
>   At subvol subvol2
>   snapshot        ./subvol2                       uuid=19d2be0a-5af1-fa44-9b3f-f21815178d00 transid=9 parent_uuid=1bac8b12-ddb2-6441-8551-700456991785 parent_transid=9
>   utimes          ./subvol2/                      atime=2021-01-11T13:41:36+0000 mtime=2021-01-11T13:41:36+0000 ctime=2021-01-11T13:41:36+0000
>   link            ./subvol2/a                     dest=a
>   unlink          ./subvol2/a
>   utimes          ./subvol2/                      atime=2021-01-11T13:41:36+0000 mtime=2021-01-11T13:41:36+0000 ctime=2021-01-11T13:41:36+0000
>   chmod           ./subvol2/a                     mode=644
>   utimes          ./subvol2/a                     atime=2021-01-11T13:41:36+0000 mtime=2021-01-11T13:41:36+0000 ctime=2021-01-11T13:41:36+0000
> 
> => the `link` command causes the receiver to fail with:
>    ERROR: link a -> a failed: File exists
> 
> Second example:
>   # case 2: same ino at different path
>   btrfs subvolume create subvol1
>   btrfs subvolume create subvol2
>   mkdir subvol1/a
>   touch subvol2/b
>   btrfs property set subvol1 ro true
>   btrfs property set subvol2 ro true
>   btrfs send -p subvol1 subvol2 | btrfs receive --dump
> 
> The produced tree state here is:
>   |-- subvol1
>   |   `-- a/        (ino 257)
>   |
>   `-- subvol2
>       `-- b         (ino 257)
> 
>   Where subvol1/a/ is a directory and subvol2/b is a file with the same
>   inode number and same generation.
> 
> Example output of the receive command:
>   At subvol subvol2
>   snapshot        ./subvol2                       uuid=ea93c47a-5f47-724f-8a43-e15ce745aef0 transid=20 parent_uuid=f03578ef-5bca-1445-a480-3df63677fddf parent_transid=20
>   utimes          ./subvol2/                      atime=2021-01-11T13:58:00+0000 mtime=2021-01-11T13:58:00+0000 ctime=2021-01-11T13:58:00+0000
>   link            ./subvol2/b                     dest=a
>   unlink          ./subvol2/a
>   utimes          ./subvol2/                      atime=2021-01-11T13:58:00+0000 mtime=2021-01-11T13:58:00+0000 ctime=2021-01-11T13:58:00+0000
>   chmod           ./subvol2/b                     mode=644
>   utimes          ./subvol2/b                     atime=2021-01-11T13:58:00+0000 mtime=2021-01-11T13:58:00+0000 ctime=2021-01-11T13:58:00+0000
> 
> => the `link` command causes the receiver to fail with:
>    ERROR: link b -> a failed: Operation not permitted
> 
> Signed-off-by: Roman Anasal <roman.anasal@bdsu.de>
> ---
>  fs/btrfs/send.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 420371c1d..33ae48442 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -6299,12 +6299,18 @@ static int changed_inode(struct send_ctx *sctx,
>  		right_gen = btrfs_inode_generation(sctx->right_path->nodes[0],
>  				right_ii);
>  
> +		u64 left_type = S_IFMT & btrfs_inode_mode(
> +				sctx->left_path->nodes[0], left_ii);
> +		u64 right_type = S_IFMT & btrfs_inode_mode(
> +				sctx->right_path->nodes[0], right_ii);
> +
> +
>  		/*
>  		 * The cur_ino = root dir case is special here. We can't treat
>  		 * the inode as deleted+reused because it would generate a
>  		 * stream that tries to delete/mkdir the root dir.
>  		 */
> -		if (left_gen != right_gen &&
> +		if ((left_gen != right_gen || left_type != right_type) &&
>  		    sctx->cur_ino != BTRFS_FIRST_FREE_OBJECTID)
>  			sctx->cur_inode_recreated = 1;
>  	}
> @@ -6359,10 +6365,10 @@ static int changed_inode(struct send_ctx *sctx,
>  	} else if (result == BTRFS_COMPARE_TREE_CHANGED) {
>  		/*
>  		 * We need to do some special handling in case the inode was
> -		 * reported as changed with a changed generation number. This
> -		 * means that the original inode was deleted and new inode
> -		 * reused the same inum. So we have to treat the old inode as
> -		 * deleted and the new one as new.
> +		 * reported as changed with a changed generation number or
> +		 * changed inode type. This means that the original inode was
> +		 * deleted and new inode reused the same inum. So we have to
> +		 * treat the old inode as deleted and the new one as new.
>  		 */
>  		if (sctx->cur_inode_recreated) {
>  			/*
> 

