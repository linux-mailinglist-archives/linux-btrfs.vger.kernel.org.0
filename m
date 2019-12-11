Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F44D11A502
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 08:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfLKHW3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 02:22:29 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33091 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfLKHW3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 02:22:29 -0500
Received: by mail-pj1-f67.google.com with SMTP id r67so8581957pjb.0;
        Tue, 10 Dec 2019 23:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U3fi9G45MNvsnCVHyyf2+/Eq1SvUT64IG1kTWUtdeCM=;
        b=Pz2vqsEnfWWVtycWZdctkqmg+bMCVpNTt2ZVNwRdLjMPsKYtBC049uY42SCojzYDDW
         w9rS8xgJ5dbnI8W7y1/AKVV+0nroaLrgFR3LG11PtXSFvJCq7YITAASPG4ZqJLT4il/v
         zZAF9UgKmZYNmFkm0yHcpcmjkYA8b05rsY8bUXkHnhECoefzusumP2OvYtRTaxWmPJIj
         fGVqfXMw29q0RI3ghsoMQWz4QSYv0rmbE4qjWsKfTXJYbwuWxFnpI0eHyZHZ4hUH0I7b
         zceMZ5tVBdIe76Ylya6LpOz3c8WcZlB2U3mp8VCtYvdSu1kOHtkoJBFEOBgn0RMUH4+k
         HS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U3fi9G45MNvsnCVHyyf2+/Eq1SvUT64IG1kTWUtdeCM=;
        b=KNcE5BrqWp96vAxsM7vSeFn9RLL8bLz6SGo2bwR4K1RTMoozx1QekhRiX2lO7uK+G4
         b0yOxB5aI0Pf4tdOZgxvwhmDmEFUlG8oy2bcSY/SFGw6XnoZWYQrjYyhysEMqaWniCIB
         fKILMX8GpdVpKzuVcbjMNou6k0MgbKSDn4jTArtTcL71BQchJ9u/QYohvg0buCGaGHqB
         eGh5ve3pY+nvhA1K31lQdYbNF58PxCJpslyr88uDIoz5Am2U0jUp7DL1+LIXkpZnQM04
         c3Xf2u31nH68og10c0Scd8rcYN9eThpfzBAMoW1HIDybTZ0KxQra6/GiL63x0IA78WOd
         HblA==
X-Gm-Message-State: APjAAAVpyqous5rHGtZuF+MCaesCWQ1n26a78EfJqfTLrr1j398ejfez
        xFiqCUwwZFqNInWnzlH8MYQ=
X-Google-Smtp-Source: APXvYqzPYTMQ5PQATDv31ArVzzbnng9Kjgckj9RVAKNlSPEIpay47zptZrb9YWZJe1ie9KujTX2Dow==
X-Received: by 2002:a17:902:6803:: with SMTP id h3mr1596838plk.319.1576048948675;
        Tue, 10 Dec 2019 23:22:28 -0800 (PST)
Received: from [192.168.1.145] ([39.109.145.141])
        by smtp.gmail.com with ESMTPSA id a19sm1525908pfn.50.2019.12.10.23.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 23:22:27 -0800 (PST)
From:   Anand Jain <anandsuveer@gmail.com>
X-Google-Original-From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] fstest: btrfs/142 fix match the device and stripe id
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@gmail.com, wqu@suse.com
References: <1576047204-30621-1-git-send-email-anand.jain@oracle.com>
 <1576047733-31132-1-git-send-email-anand.jain@oracle.com>
Message-ID: <a3adf1ce-588e-f615-13a5-289fb86e2cdc@oracle.com>
Date:   Wed, 11 Dec 2019 15:22:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1576047733-31132-1-git-send-email-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Discard this patch. Qu is fixing with a helper function to find
device for the given stripe id dynamically.

Thanks, Anand

On 12/11/19 3:02 PM, Anand Jain wrote:
> We re-aliened the device allocation order to the device id oder, if the
> available space on the device is all same. So for this reason the test
> cases which is hard coded with the device and the stripe id fails. Fix
> it with the new expected device and stripe id.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Update the comment which referred to the bad stripe and good stripe.
> 
>   tests/btrfs/142 | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/btrfs/142 b/tests/btrfs/142
> index a23fe1bf4b75..06811a23e662 100755
> --- a/tests/btrfs/142
> +++ b/tests/btrfs/142
> @@ -89,12 +89,13 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foobar" |\
>   
>   # step 2, corrupt the first 64k of one copy (on SCRATCH_DEV which is the first
>   # one in $SCRATCH_DEV_POOL
> -echo "step 2......corrupt file extent" >>$seqres.full
>   
>   ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
>   logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
>   physical_on_scratch=`get_physical ${logical_in_btrfs}`
>   
> +echo "step 2......corrupt file extent on device $SCRATCH_DEV logic $logical_in_btrfs physical $physical_on_scratch" >>$seqres.full
> +
>   _scratch_unmount
>   $XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical_on_scratch 64K" $SCRATCH_DEV |\
>   	_filter_xfs_io_offset
> @@ -104,15 +105,15 @@ _scratch_mount -o nospace_cache
>   # step 3, 128k dio read (this read can repair bad copy)
>   echo "step 3......repair the bad copy" >>$seqres.full
>   
> -# since raid1 consists of two copies, and the bad copy was put on stripe #1
> -# while the good copy lies on stripe #0, the bad copy only gets access when the
> -# reader's pid % 2 == 1 is true
> +# since raid1 consists of two copies, and the bad copy was put on stripe #0
> +# while the good copy lies on stripe #1, the bad copy only gets access when the
> +# reader's pid % 2 == 0 is true
>   start_fail
>   while [[ -z ${result} ]]; do
>   	# enable task-filter only fails the following dio read so the repair is
>   	# supposed to work.
>   	result=$(bash -c "
> -	if [[ \$((\$\$ % 2)) -eq 1 ]]; then
> +	if [[ \$((\$\$ % 2)) -eq 0 ]]; then
>   		echo 1 > /proc/\$\$/make-it-fail
>   		exec $XFS_IO_PROG -d -c \"pread -b 128K 0 128K\" \"$SCRATCH_MNT/foobar\"
>   	fi");
> 

