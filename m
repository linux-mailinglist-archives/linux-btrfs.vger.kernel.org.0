Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E1D21C4F5
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jul 2020 17:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgGKP6y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jul 2020 11:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgGKP6y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jul 2020 11:58:54 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04C5C08C5DD
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jul 2020 08:58:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id s16so4895423lfp.12
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jul 2020 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BOEiqVr/lEz/LFvVhPo/R38thNVjstWQiPoeJ0URMog=;
        b=kuOzW3sc7ZSlso0wv6dEk0MHnx6069LeqPBOdmL7QFFsAlLKFKmqA1GruWidbuPWv8
         SPjXPLgibMQTkdG0q7n7U5MlGovaNjHL7QL72RPVGctytrAWG3K4W3r6w09Yb9+TSWVz
         xf1dGUds/Fcy8DiHMrYzO5bgm5We23IglECIMWE9VG+q5EdrZKVF7suDEjaVNTKgeFmu
         v/Fhs+PaiGsCpcUi8lUjbzLxSLjNk50ZgD7sILiX7tlAJum/N7pZxTZ18VSbrmIITBDz
         LLpWJUJm8wkUqGMkCyLwqU5FtmTp2HYKlsPLJzgN1+1Cv4YnmuO9Qn30hFBd61Nl+H1C
         L8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BOEiqVr/lEz/LFvVhPo/R38thNVjstWQiPoeJ0URMog=;
        b=nRjIpzUvAUHezLwbeSFAkVS0fCCobTE9kzXM0aMbRMmn/kppztQVb74zievFhUlQaH
         o5tYoiJr6dY6oGIU5fDrK8sT5RgQCiUMUi66uGO45BHIcBQslWJH8HVhfqFBFanDj2lD
         rv5fklb4DF/zYdvWDETrI6qFsT0l2S+ydbj+PcJqq4MvBerBRnyKgKvcWIIe8bBUkVMz
         jejN4HeT1n+QM963HUFo0PMY4mwEXXqKeFDxwV9zUT89AKIgc4WYAInPBoDF5tiLocxA
         hvEafEsN3u7cUCT+9PRgvLCvikTcWT7LeAUpVg4A0ycb2mOwfTqpmlDXVN7bXxq8Sy42
         l3ZA==
X-Gm-Message-State: AOAM5336Tw5BoW59I6IV+dRJSB1ACz7K0FpB7ru7aS0SSaaDfaYcjj0u
        7StLCxPFNu/zvxA3Q1T6l6hqH/LV
X-Google-Smtp-Source: ABdhPJy76s8E4VZOEDpexqmk6UqYgAIxCH12E3RQKcJvt2F68bmN5I4SPZJcRVuFeuhEBNaU1nEu6w==
X-Received: by 2002:ac2:5f07:: with SMTP id 7mr47901590lfq.132.1594483129686;
        Sat, 11 Jul 2020 08:58:49 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:9bf7:50a4:1b78:5915:6126? ([2a00:1370:812d:9bf7:50a4:1b78:5915:6126])
        by smtp.gmail.com with ESMTPSA id u8sm3227815lff.7.2020.07.11.08.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2020 08:58:48 -0700 (PDT)
Subject: Re: Rebalancing Question
To:     swestrup@gmail.com, linux-btrfs@vger.kernel.org
References: <CAJt7KB-c4vRYgjJ1WZJyNZuey6nH=y2BcQNVYJa6YAG9MTfKhQ@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUdpQkR4aVJ3d1JCQUMz
 Q045d2R3cFZFcVVHbVNvcUY4dFdWSVQ0UC9iTENTWkxraW5TWjJkcnNibEtwZEc3CngrZ3V4
 d3RzK0xnSThxamYvcTVMYWgxVHdPcXpEdmpIWUoxd2JCYXV4WjAzbkR6U0xVaEQ0TXMxSXNx
 bEl3eVQKTHVtUXM0dmNRZHZMeGpGc0c3MGFEZ2xnVVNCb2d0YUlFc2lZWlhsNFgwajNMOWZW
 c3R1ejQvd1h0d0NnMWNOLwp5di9lQkMwdGtjTTFuc0pYUXJDNUF5OEQvMWFBNXFQdGljTEJw
 bUVCeHFrZjBFTUh1enlyRmxxVncxdFVqWitFCnAyTE1sZW04bWFsUHZmZFpLRVo3MVcxYS9Y
 YlJuOEZFU09wMHRVYTVHd2RvRFhnRXAxQ0pVbitXTHVyUjBLUEQKZjAxRTRqL1BISEFvQUJn
 cnFjT1RjSVZvTnB2MmdOaUJ5U1ZzTkd6RlhUZVkvWWQ2dlFjbGtxakJZT05HTjNyOQpSOGJX
 QS8wWTFqNFhLNjFxam93UmszSXk4c0JnZ00zUG1tTlJVSllncm9lcnBjQXIyYnl6NndUc2Iz
 VTdPelVaCjFMbGdpc2s1UXVtMFJONzdtM0kzN0ZYbEloQ21TRVk3S1pWekdOVzNibHVnTEhj
 ZncvSHVDQjdSMXc1cWlMV0sKSzZlQ1FITCtCWndpVThoWDNkdFRxOWQ3V2hSVzVuc1ZQRWFQ
 cXVkUWZNU2kvVXgxa2JRbVFXNWtjbVY1SUVKdgpjbnBsYm10dmRpQThZWEoyYVdScVlXRnlR
 R2R0WVdsc0xtTnZiVDZJWUFRVEVRSUFJQVVDU1hzNk5RSWJBd1lMCkNRZ0hBd0lFRlFJSUF3
 UVdBZ01CQWg0QkFoZUFBQW9KRUVlaXpMcmFYZmVNTE9ZQW5qNG92cGthK21YTnpJbWUKWUNk
 NUxxVzV0bzhGQUo0dlA0SVcrSWM3ZVlYeENMTTcvem05WU1VVmJyUW5RVzVrY21WNUlFSnZj
 bnBsYm10dgpkaUE4WVhKMmFXUnFZV0Z5UUc1bGQyMWhhV3d1Y25VK2lGNEVFeEVDQUI0RkFr
 SXR5WkFDR3dNR0N3a0lCd01DCkF4VUNBd01XQWdFQ0hnRUNGNEFBQ2drUVI2TE11dHBkOTR4
 ajhnQ2VJbThlK2U0cXhETWpRRXhGYlVMNXdNaWkKWUQwQW9LbUlCUzVIRW9wL1R5UUpkTmc2
 U3Z6VmlQRGR0Q1JCYm1SeVpYa2dRbTl5ZW1WdWEyOTJJRHhoY25acApaR3BoWVhKQWJXRnBi
 QzV5ZFQ2SVhBUVRFUUlBSEFVQ1Bxems4QUliQXdRTEJ3TUNBeFVDQXdNV0FnRUNIZ0VDCkY0
 QUFDZ2tRUjZMTXV0cGQ5NHlEdFFDZ2k5NHJoQXdTMXFqK2ZhampiRE02QmlTN0Irc0FvSi9S
 RG1hN0tyQTEKbkllc2JuS29MY1FMYkpZbHRDUkJibVJ5WldvZ1FtOXljMlZ1YTI5M0lEeGhj
 blpwWkdwaFlYSkFiV0ZwYkM1eQpkVDZJVndRVEVRSUFGd1VDUEdKSERRVUxCd29EQkFNVkF3
 SURGZ0lCQWhlQUFBb0pFRWVpekxyYVhmZU1pcFlBCm9MblllRUJmOGNvV2lud3hUZThEVjBS
 T2J4N1NBS0RFamwzdFFxZEY3MGFQd0lPMmgvM0ZqczJjZnJRbVFXNWsKY21WcElFSnZjbnBs
 Ym10dmRpQThZWEoyYVdScVlXRnlRR2R0WVdsc0xtTnZiVDZJWlFRVEVRSUFKUUliQXdZTApD
 UWdIQXdJR0ZRZ0NDUW9MQkJZQ0F3RUNIZ0VDRjRBRkFsaVdBaVFDR1FFQUNna1FSNkxNdXRw
 ZDk0d0ZHd0NlCk51UW5NRHh2ZS9GbzNFdllJa0FPbit6RTIxY0FuUkNRVFhkMWhUZ2NSSGZw
 QXJFZC9SY2I1K1NjdVFFTkJEeGkKUnlRUUJBQ1F0TUUzM1VIZkZPQ0FwTGtpNGtMRnJJdzE1
 QTVhc3VhMTBqbTVJdCtoeHpJOWpEUjkvYk5FS0RUSwpTY2lIbk03YVJVZ2dMd1R0KzZDWGtN
 eThhbit0VnFHTC9NdkRjNC9SS0tsWnhqMzl4UDd3VlhkdDh5MWNpWTRaCnFxWmYzdG1tU045
 RGxMY1pKSU9UODJEYUpadXZyN1VKN3JMekJGYkFVaDR5UkthTm53QURCd1FBak52TXIvS0IK
 Y0dzVi9VdnhaU20vbWRwdlVQdGN3OXFtYnhDcnFGUW9CNlRtb1o3RjZ3cC9yTDNUa1E1VUVs
 UFJnc0cxMitEawo5R2dSaG5ueFRIQ0ZnTjFxVGlaTlg0WUlGcE5yZDBhdTNXL1hrbzc5TDBj
 NC80OXRlbjVPckZJL3BzeDUzZmhZCnZMWWZrSm5jNjJoOGhpTmVNNmtxWWEveDBCRWRkdTky
 Wkc2SVJnUVlFUUlBQmdVQ1BHSkhKQUFLQ1JCSG9zeTYKMmwzM2pNaGRBSjQ4UDdXRHZLTFFR
 NU1Lbm4yRC9USTMzN3VBL2dDZ241bW52bTRTQmN0YmhhU0JnY2tSbWdTeApmd1E9Cj1nWDEr
 Ci0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0K
Message-ID: <f37d1f09-e89d-b468-2de9-4dad1d98d750@gmail.com>
Date:   Sat, 11 Jul 2020 18:58:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJt7KB-c4vRYgjJ1WZJyNZuey6nH=y2BcQNVYJa6YAG9MTfKhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

11.07.2020 17:42, Stirling Westrup пишет:
> I have a BTRFS built with two devices md0 and md1 on a server. I wish
> to move as much data as will fit from md0 to md1, but I cannot figure
> out a balance command that will do that.
> 
> My use case is a file server with a fixed number of hard drive slots
> and two raids. md0 is a raid using most of the slots with small
> drives, and md1 is a raid using the remaining slots with large drives.
> I'm trying to shrink md0, so I can remove some small drives and put in
> new large drives to add to md1.
> 
> I have read the notes on the balance command several times but I can't
> figure out how to get it to do what I want, if it's even possible.
> 

You should be able to shrink md0 which will relocate data beyond new
size to another device(s). See example in btrfs-filesystem:


       $ btrfs filesystem resize -1G /path

       $ btrfs filesystem resize 1:-1G /path

       Shrink size of the filesystem’s device id 1 by 1GiB. The first
syntax expects a
       device with id 1 to exist, otherwise fails. The second is
equivalent and more
       explicit. For a single-device filesystem it’s typically not
necessary to specify the
       devid though.


This assumes you are using single or dup profiles, as other profiles
require at least two devices anyway and you may not be able to shrink
md0 too far.
