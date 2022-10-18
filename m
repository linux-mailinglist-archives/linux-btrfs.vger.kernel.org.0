Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F23602E6D
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 16:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiJRO1u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 10:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiJRO1s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 10:27:48 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1FDC0981
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:27:46 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id t25so8719544qkm.2
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LdNQEqJlTgCNX/thLCc2I4lCuFk0cwSwMo4N+YBcHrU=;
        b=Jw3yp01Fx8maduVqaLh4vDmteS407yLFl5ZE7frNlvZ8zooT3+k1jSjE8D2Iirs70S
         TqHh3PG2+dbCgfu9vTyGKgdkv3ctt7NTcfvONwjOG/ii9t1Zuvuz+sMKJT8Bo2OVW63o
         1jye23159xYwKO04xSM5rUCQwSaQYwr4g++x2gyB+SUAijFzb8ce+quxduSCuzedwuS3
         QtE03ulcNuD67t7NavKOr2fiCO7djW9nm2lOc2wB+OXbPmAod5bLgkBFi1MRTJUkOoRw
         djY2t4Dezpyg1Dg90vsnBOGH7hPnz90ov0LsznXE2docTJGEYn5CEwOF30c8Xz3gTVMM
         gP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdNQEqJlTgCNX/thLCc2I4lCuFk0cwSwMo4N+YBcHrU=;
        b=u0TwOlbQ69weBzJNPF0oefUnTYszYkwKbM3ocOcF7ByulFFJXnN+8upOnxmAXhL/d2
         ge72fh3m8h3Cl/t3MGl951NE1KdZXEwrNKnIVm1oMwgsy8HafE0bhNKG1ftcLEuJYK4p
         7i+7o2mUEAhwbbfdjmasUqJyoQYoMSvuvxmyhQE4O2MhSH05Q00A3k0i9fmsKOAzjhDj
         WQd+jR+cYLypmvMD+UHFgie7UNaQf7uhT2c4uXr4IWF3Vrh64xH+OmxkCFkpS3B0iEQS
         kkeUypU2Yb3tn4FbayUVuuMTepV79t+ePH/y01x9y9SVSwOkF5VJz3qDa++6a1FWcp9E
         qKgw==
X-Gm-Message-State: ACrzQf12Tqa2NZUd1KIcLl+srdrJL3vKiA7AIpZ5X4pBaQof8d1M1IAA
        1niv/xrbr3eXIljSydLkNCv9EdpWoSUgxA==
X-Google-Smtp-Source: AMsMyM59n58wTRcLL76oWw8s1tDFcQgHc5h5+3OEuGapoJftavQMiHJOzwrYFsC2ZqUa2jLzbISG4A==
X-Received: by 2002:a05:620a:2601:b0:6bc:70bb:c56b with SMTP id z1-20020a05620a260100b006bc70bbc56bmr2052523qko.416.1666103265809;
        Tue, 18 Oct 2022 07:27:45 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b006ed99931456sm2419348qkh.88.2022.10.18.07.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 07:27:45 -0700 (PDT)
Date:   Tue, 18 Oct 2022 10:27:44 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 02/16] btrfs: move larger compat flag helpers to their
 own c file
Message-ID: <Y0634IUR2qH2vK/4@localhost.localdomain>
References: <cover.1666033501.git.josef@toxicpanda.com>
 <bd00bf180e1f4437d887fb7b893bd37d5103c25c.1666033501.git.josef@toxicpanda.com>
 <761748f6-ae18-5467-548e-256d56ce5f92@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <761748f6-ae18-5467-548e-256d56ce5f92@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 18, 2022 at 07:42:52AM +0000, Johannes Thumshirn wrote:
> On 17.10.22 21:09, Josef Bacik wrote:
> > These helpers use a lot of different functions that would be defined
> > elsewhere.  Push them into a C file so we don't end up with weird header
> > file dependencies.
> 
> Can't this be merged into patch 1? I find it a bit wired, that these functions
> are moved twice.
> 

Yeah you're right, sorry about that, some of this stuff is a "hey this should go
here", and then I tackled a different part later and then moved it again.  I'll
clean this up and re-send.  Thanks,

Josef
