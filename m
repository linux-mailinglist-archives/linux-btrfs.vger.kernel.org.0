Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B11E42E47B
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Oct 2021 00:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhJNW6W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 18:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhJNW6W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 18:58:22 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A35CC061570
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 15:56:16 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id w2so7314898qtn.0
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 15:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fvca2lB/y52G0BoG/oHiknUmp44/sNEv2t3R/Dnk6zo=;
        b=MQeuHcQXWVTwgWiXmkJ7+Hijo7+EN8sczoTBZCEw7uwMhRh/6gRNJLvOA2sv6uysyL
         VNtQQse33L73iviNB3o8MQzjA+4IZRgtdwMMU1pQQT4abzeGx5aq0n+MlUBQ2rPVU4qp
         IMtHdIc3IDsUy18BgPr6F9wDT82v3S+aDA5R49YoEpnNRTLsA3Q/ppXMFmDb8bzyk9wF
         FqWqgyt2Ad3SOCjBWl9UXVboCHhGCiJzltuDvGKQ57A5JcdfByIeW2PCnZGPmzQo1yKu
         sx7i+enTDjYXtu9fPskXEl1dmUdhK1MTX7sjJnAN5/Jhl2EWjDWn/ap/aoItqJe3Wtgf
         CVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fvca2lB/y52G0BoG/oHiknUmp44/sNEv2t3R/Dnk6zo=;
        b=IW54gA7jBDDjzQj6NzK/77jpaLq0v7m32A92eJtrOu2ZntJhCjGTUP2/SvljEQcZDe
         Ah0O1udz/8htJqOsUSbTaEaacFWgt7ExvJKdsC3IaaLX0V6S3jeKHAYjSAKF68jfvIz+
         VtkPM87Gcb6RSGbczPj83kB0IZm9RXSQDqZh/YwkDIz/k6D9MjfmPrl5eSoblUoY7vOd
         9QJJfgQUBSEwqcNWf9GZnTq1GQ2R/GEdQaNVv0N/U3w1xJoGxnstgXkHAE+xb/f0H1vq
         121w5/n6/pdHHR+c2fEX49VqQDPMfSuFRWc31lhWnIL5fAioeJBDJWJE1Pd9VeQBePZd
         mZzQ==
X-Gm-Message-State: AOAM530DT2LyoCY7NyxdRBOyOq86IDOoRt153HrcF2z3L7N9aKYFLnV4
        cW+iq77SgfkJ1erLVeZIlLQiwAKEd8b1ew==
X-Google-Smtp-Source: ABdhPJxEXhc9/cpIxgS2NXNlPMINCWk7CjUQbv5VoIRDh71+bSJCoV4AvaqUcAkrOTb76W0p084fAw==
X-Received: by 2002:ac8:1e0e:: with SMTP id n14mr9791218qtl.95.1634252175551;
        Thu, 14 Oct 2021 15:56:15 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j23sm1920453qtr.23.2021.10.14.15.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 15:56:14 -0700 (PDT)
Date:   Thu, 14 Oct 2021 18:56:13 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: test-misc: search the backup slot to use
 at runtime
Message-ID: <YWi1jfJdsnIcLRbj@localhost.localdomain>
References: <20211013011233.9254-1-wqu@suse.com>
 <YWhOiG3rQvcbiys+@localhost.localdomain>
 <5bd2f336-baeb-de19-1eff-9ef766cc2ff6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bd2f336-baeb-de19-1eff-9ef766cc2ff6@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 15, 2021 at 06:36:36AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/10/14 23:36, Josef Bacik wrote:
> > On Wed, Oct 13, 2021 at 09:12:33AM +0800, Qu Wenruo wrote:
> > > Test case misc/038 uses hardcoded backup slot number, this means if we
> > > change how many transactions we commit during mkfs, it will immediately
> > > break the tests.
> > > 
> > > Such hardcoded tests will be a big pain for later btrfs-progs updates.
> > > 
> > > Update it with runtime backup slot search.
> > > 
> > > Such search is done by using current filesystem generation as a search
> > > target and grab the slot number.
> > > 
> > > By this, no matter how many transactions we commit during mkfs, the test
> > > case should be able to handle it.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > > Changelog:
> > > v2:
> > > - Use run_check() instead of manually redirect output to "$RESULT"
> > > - Quote "$main_root_ptr"
> > > ---
> > >   .../038-backup-root-corruption/test.sh        | 47 ++++++++++++-------
> > >   1 file changed, 29 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/tests/misc-tests/038-backup-root-corruption/test.sh b/tests/misc-tests/038-backup-root-corruption/test.sh
> > > index b6c3671f2c3a..bf41f1e0952b 100755
> > > --- a/tests/misc-tests/038-backup-root-corruption/test.sh
> > > +++ b/tests/misc-tests/038-backup-root-corruption/test.sh
> > > @@ -17,25 +17,35 @@ run_check $SUDO_HELPER touch "$TEST_MNT/file"
> > >   run_check_umount_test_dev
> > > 
> > >   dump_super() {
> > > -	run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$TEST_DEV"
> > > +	# In this test, we will dump super block multiple times, while the
> > > +	# existing run_check*() helpers will always dump all the output into
> > > +	# the log, flooding the log and hide real important info.
> > > +	# Thus here we call "btrfs" directly.
> > > +	$SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$TEST_DEV"
> > >   }
> > > 
> > > -# Ensure currently active backup slot is the expected one (slot 3)
> > > -backup2_root_ptr=$(dump_super | grep -A1 "backup 2" | grep backup_tree_root | awk '{print $2}')
> > > -
> > >   main_root_ptr=$(dump_super | awk '/^root\t/{print $2}')
> > > +# Grab current fs generation, and it will be used to determine which backup
> > > +# slot to use
> > > +cur_gen=$(dump_super | grep ^generation | awk '{print $2}')
> > > +backup_gen=$(($cur_gen - 1))
> > > +
> > > +# Grab the slot which matches @backup_gen
> > > +found=$(dump_super | grep backup_tree_root | grep -n "gen: $backup_gen")
> > > 
> > > -if [ "$backup2_root_ptr" -ne "$main_root_ptr" ]; then
> > > -	_log "Backup slot 2 not in use, trying slot 3"
> > > -	# Or use the next slot in case of free-space-tree
> > > -	backup3_root_ptr=$(dump_super | grep -A1 "backup 3" | grep backup_tree_root | awk '{print $2}')
> > > -	if [ "$backup3_root_ptr" -ne "$main_root_ptr" ]; then
> > > -		_fail "Neither backup slot 2 nor slot 3 are in use"
> > > -	fi
> > > -	_log "Backup slot 3 in use"
> > > +if [ -z "$found" ]; then
> > > +	_fail "Unable to find a backup slot with generation $backup_gen"
> > >   fi
> > > 
> > > -run_check "$INTERNAL_BIN/btrfs-corrupt-block" -m $main_root_ptr -f generation "$TEST_DEV"
> > > +slot_num=$(echo $found | cut -f1 -d:)
> > > +# To follow the dump-super output, where backup slot starts at 0.
> > > +slot_num=$(($slot_num - 1))
> > 
> > What happens if we're on $slot_num == 0?  Seems like this would mess up, right?
> > Thanks,
> 
> Note that, the $found is from "grep -n" which starts its line number at 1.
> 
> Thus $slot_num will always be >= 1, and nothing will be wrong.
> 

I missed the -n part, sorry about that, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
