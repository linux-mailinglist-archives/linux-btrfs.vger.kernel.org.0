Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E72B3FE244
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 20:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344260AbhIASRy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 14:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhIASRy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Sep 2021 14:17:54 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1932BC061575
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Sep 2021 11:16:57 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id m18so786801lfl.10
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZQG2Hfgl0JVGYXm3RIIniMiTnbhhQ7Pv0z/zZygImMk=;
        b=II3Q0ExxKRq0qpqrS7+v5w0pwNbuL0CNZYlI+Ddge3YawfrxUdgA9RAfGTA24j66Kg
         xZ9uEs1wzqrtyEdD/zN9yA10aZlkp45uebGaM9bgrvzcCQZU7ezDn4l/UD3Vsr9t/ZVk
         ctIYXBqUJKsodiJT0aAGE3Efiouy4PyF8BJSTJEo/DT/GnnTxWEK6jXa/YmgEfFbMuQf
         97QrrTOd1FXEIp92iYLGNKPhuwzplIgYIKsVd/KOXhQSwyD89jrMdDtyHrEfghw1RTaX
         tmn3KPdulkR7NxYxS8npdsPQqU5Gwi22NCuxVrXZw8lEoJQrhrFcIioVJxCJc0ZX9gJ2
         ojuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZQG2Hfgl0JVGYXm3RIIniMiTnbhhQ7Pv0z/zZygImMk=;
        b=SqmKmfvr09d22uKfUcAoFoQv6H2CidjQ2Xj8itbRbE6JIE/SaHbyUftqO7dffArgDp
         StGawe7yju9o3iSTpxNmMPvT9gfSbN+mThCjgC9deIWor4SoNlXdIxnztILK9w5JJjb7
         WyeiKAS2NjOW/9jPMIAl1fstGLS/YNBh2hqwShUHc6RtbO7Z1BLu1YbAT5LjS3ny3XKt
         /2BpxLzW1/JrogkpAz6oL9U+6DLsZEThRMnWA6FkBq3sgKBZjm4oF8TMKGUsttQEAPu2
         B32Q+4/Ad4qeyqlnNZE9UgqyIEDBcEC2qZutCinJQ9YC6TqbYedGgTkUxamBHRwP1A45
         t8cw==
X-Gm-Message-State: AOAM532eX+mCqHv2H5FSq8nK6zXJxW+V21V/59jv49mof7kwuhMFSy3n
        K/TdDBTS+I4MXh2rAeVbY7edECu1EIc=
X-Google-Smtp-Source: ABdhPJwJ/5dIHhNpy5GDtmgxYUDfRdvQbn3trjJX/jPjl0s+CmbTdlr5aopvlx6DgNrUKqpro468lg==
X-Received: by 2002:a05:6512:2356:: with SMTP id p22mr533954lfu.524.1630520214957;
        Wed, 01 Sep 2021 11:16:54 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:8deb:5c9c:cef9:590c:9452? ([2a00:1370:812d:8deb:5c9c:cef9:590c:9452])
        by smtp.gmail.com with ESMTPSA id b21sm22027lfi.104.2021.09.01.11.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 11:16:54 -0700 (PDT)
Subject: Re: Backup failing with "failed to clone extents" error
To:     Darrell Enns <darrell@darrellenns.com>
Cc:     fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H5UH012m=19sj=4ob-d_LbWqb63t7tYz9bmz1wXyFcctw@mail.gmail.com>
 <CAOaVUnVL508_0xJovhLqxv_zWmROEt-DnmQVkNkTwp0GHPND=Q@mail.gmail.com>
 <CAL3q7H7MxhvzLAe1pv+R8J=fNrEX2bDMw1xWUcoZsCCG-mL5Mg@mail.gmail.com>
 <CAOaVUnXB4qoAyVcm3H03Bj2rukZ+nbSzOdB4TsKpJjH8sqOr7g@mail.gmail.com>
 <CAL3q7H7vTFggDHDq=j+es_O3GWX2nvq3kqp3TsmX=8jd7JhM1A@mail.gmail.com>
 <CAOaVUnW6nb-c-5c56rX4wON-f+JvZGzJmc5FMPx-fZGwUp6T1g@mail.gmail.com>
 <CAL3q7H6h+_7P7BG11V1VXaLe+6M+Nt=mT3n51nZ2iqXSZFUmOA@mail.gmail.com>
 <CAL3q7H5p9WBravwa6un5jsQUb24a+Xw1PvKpt=iBdHp4wirm8g@mail.gmail.com>
 <CAOaVUnXDzd-+jvq95DGpYcV7mApomrViDhiyjm-BdPz5MvFqZg@mail.gmail.com>
 <CAL3q7H5y6z7rRu-ZsZe_WXeHteWx1edZi+L3-UL0aa0oYg+qQA@mail.gmail.com>
 <CAOaVUnW6GzK6ANOUz4x+BBXz90sgaT_TJuQUm869CYa6qH2KSA@mail.gmail.com>
 <ce80dccc-f829-5193-a97b-262c669fb29c@gmail.com>
 <CAOaVUnUTA8Anepp3dhnzXXEGjgeeM=VwTERZvWMH6ptrNHZOjg@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <06e92a0b-e71b-eb21-edb5-9d2a5513b718@gmail.com>
Date:   Wed, 1 Sep 2021 21:16:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAOaVUnUTA8Anepp3dhnzXXEGjgeeM=VwTERZvWMH6ptrNHZOjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01.09.2021 20:52, Darrell Enns wrote:
>> Most likely. Did you simply make received subvolume read-write?
> 
> I believe so.

Well, here you are. There was proposed patch to clear received_uuid on
clearing read-only subvolume property, but it has never been applied.

> Is there a different way of doing it that would have
> avoided this situation? 

Yes. You should have created clone (read-write snapshot) of received
sibvolume and use it as your root. Received_uuid is automatically
cleared in writable snapshot.


> On a new subvol, would the received uuid
> normally be blank? 

Yes.

> Any suggestions on how to "fix" mine?
> 

I am not sure if it is even possible to clear received_uuid from user
space - the only available IOCTL is for setting it (there are extra
mandatory parameters and I do not know how to set them in this case).
You may try ./examples/set_received_uuid.py from
git://github.com/knorrie/python-btrfs while setting stransid and stime
to zero.

What will surely work is cloning you root subvolume and switching to
clone. If course you will need to restart all replication streams
beginning with full send of new root. But as it looks like you will need
to restart it anyway.
