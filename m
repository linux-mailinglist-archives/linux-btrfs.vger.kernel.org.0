Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48375228784
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 19:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgGURks (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 13:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbgGURks (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 13:40:48 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B3AC061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 10:40:47 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id e13so20161811qkg.5
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 10:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=x5gXAONGd67nYT3WRUij4BlkeNXNewv464hvQUhX8iE=;
        b=Bs1jQng0wuI7Q13HOUl8TFyH78n4bPdpbgoJKHY/nMkGpRnRmrq6jV7+JBHy0vPV15
         D8TMT08d+BwN00nGZdCkrJZKDz3ON4Az7c6AHQn6/4CFtUWwCK/ol5+Ei2MA+g0s5KL+
         g3Ycr79cM1X3D/ZjQX8GVkP3Ubah8mr9ZLv/rfwAtYKtjnDhfAWrYul+mCzG/1BFEsNS
         ZaOBfCDTRI9/vvtUUDQmdDikbvnZVheBVvBU/wRpHoQ8tR0FgZ3TyudrWvmuwJ2oLoeb
         Sy5yDfyC40dr9fjCJJapMVByKR/JGgM3ASp355lLMH2dVw9fkiBUcpcl4z1ihM4ZlGLx
         +mYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x5gXAONGd67nYT3WRUij4BlkeNXNewv464hvQUhX8iE=;
        b=Y0rhtiLIWvIuw51f/thVAnk7G38osvgqoTaqTh/A+nZZsSY4dg8ExSUPTnhUOGpcXd
         iWCThs8QnTkraEl7y1SEhietF4TnWVfYHn0NlG7AlLK65eXjCpDzZwuHDDRowIkaBYvg
         Ix5vJcBHBrWLWsZaYYeAKs47HZupjCTqCyS4sdhCZiNGkcYHjm8NatFi4kpEv9wv4mbs
         EyqjsJr2nFIyFW7N0nxGMCOsXS5u719Fj9i9tIFy6KP5U0BOwOAwhv1bytqEpIihgg10
         7DG8WbiP8164wolIvkuabvJ0lGQUn7MuYCNRjn/h2f9fW65qeFMgPCpmebvgsl3D9B7e
         0Jqg==
X-Gm-Message-State: AOAM5314Wv23wYljVd194p/70SxGMbX8bhCAbSx/Sg34+R7yloiITTnB
        TLpKeGp4HjPkRimefnkv1zr/Vw==
X-Google-Smtp-Source: ABdhPJy0aVqN3BQOrfY2NEk34QGbkjx189gdmhme+CXASw/mBScoiKc65lelW9ZFx99yAXDVDbRMXg==
X-Received: by 2002:a37:9a13:: with SMTP id c19mr26695471qke.56.1595353246735;
        Tue, 21 Jul 2020 10:40:46 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o15sm3080021qko.67.2020.07.21.10.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 10:40:46 -0700 (PDT)
Subject: Re: [PATCH][v2] btrfs: introduce rescue=onlyfs
To:     Graham Cobb <g.btrfs@cobb.uk.net>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200721151057.9325-1-josef@toxicpanda.com>
 <69cf9558-5390-8d14-21b2-51f4c82eeed7@cobb.uk.net>
 <20200721171626.GP3703@twin.jikos.cz>
 <870ffc4d-00c2-53bb-578b-6dffc85f86b0@cobb.uk.net>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <abfc1a19-5edf-6e60-f1a8-272f6637d111@toxicpanda.com>
Date:   Tue, 21 Jul 2020 13:40:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <870ffc4d-00c2-53bb-578b-6dffc85f86b0@cobb.uk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/21/20 1:34 PM, Graham Cobb wrote:
> On 21/07/2020 18:16, David Sterba wrote:
>> On Tue, Jul 21, 2020 at 04:56:55PM +0100, Graham Cobb wrote:
>>> If it means "only filesystem" that doesn't make sense to me - the whole
>>> thing is the filesystem. I guess "only data" might be more meaningful
>>> but if the aim is to turn on as much recovery as possible to help the
>>> user to save their data then why not just say so?
>>>
>>> Something like "rescue=max", "rescue=recoverymode", "rescue=dataonly",
>>> "rescue=ignoreallerrors" or "rescue=emergency" might be more meaningful.
>>
>>  From user perspective the option should have a high level semantics,
>> like you suggest above. We should add individual options to try to work
>> around specific damage if not just for testing purposes, having more
>> flexibility is a good thing.
> 
> I would also prefer not to have checksum checking disabled by this "try
> harder" option. I would imagine turning on "ignore whatever checks you
> can to get me my data back mode", retrieving all the readable data with
> valid checksums and getting errors for things which cannot be verified.
> Then I would make a decision as to whether to enable another option to
> even provide files which the filesystem cannot guarantee have not been
> corrupted because it can't check checksums. Even if that is all the
> files (because the checksum tree is destroyed) I should have to make an
> explicit acknowledgement that I want that.
> 

If somebody wants to add finer grained stuff later I'm fine with that, right now 
I'm addressing the case where a lot of things are dead.  Thanks,

Josef
