Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A9A1F0B00
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jun 2020 13:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgFGLuT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jun 2020 07:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgFGLuT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Jun 2020 07:50:19 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01A2C08C5C2
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Jun 2020 04:50:18 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x27so8476018lfg.9
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Jun 2020 04:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h65EqruJ9Y8Us+vxaMFj6Ax7gHY5kjt5JASsUETuaUI=;
        b=ZqgoqEqEuesWdzJ1KpEhKEG471F3r3FXdeO6iXb0baK5frpu9AJaExphu2KMdp7cx1
         A0nPsbjxpZ2YHzE02svcrzjER9Ru9U1PaKFSZ+q3ssNSGr5AcRP8ZlERbnTmmDNY6R+u
         mfeQdNWCulMQRcRpUsfC7OSI2/HX3ZTKqGvuToVghItUbdmcZ9g7ghgmNk0q4PIB3DVA
         mMP8LNe0dRenbFVXgY8Py2dc1JJ2CatHHw0J9+RpqqhYxmafr140cE35TOxJz7KJqEIk
         aTRFGRSzdYPLD20eVp8KGGyGrw5SGIQvFtraNK2WO6X74iwvRK+OMnfd/Bk4LF3CrBER
         ct3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=h65EqruJ9Y8Us+vxaMFj6Ax7gHY5kjt5JASsUETuaUI=;
        b=Yg97EtiGQPK7MlmtexQtwaGpKV2VQ57oUNf6M4XR3MJJ3h+LKey3U+B0PY0x3snMT6
         TjcGrYCl7ww0tHRxJlPLF0QXcAH6frlC9lyOsCUhwkHjMckAaGURt6PiOlz4I9TT25xO
         rzPBtuDj0T99GMMrk2HJrU80GRDHUJ41VpyIgrSVGGsGDDflyExD6bfRvotwtJ0k1fgJ
         k2IRX0BT60GUY6WZ4Wk0e0WPunGE9BADjA+UpDtBJuEorCQAiVgvN70nnpu5rErx5UPv
         KMl5w5Cn3redRceqXGu8uWqKLJ0nSu3wxlPCl8CjZ4gKCztAjGWkjaZ8F8lYGFjvqLE8
         vN4A==
X-Gm-Message-State: AOAM531Xlg6nEyrY6Xn0me8KYnSEqwIMtD7OPaCWZDz1M2NSQCriaLV4
        EL8kD+4Ae6w5A0gimqereko2oFfB
X-Google-Smtp-Source: ABdhPJyd5pnPGXKU+3cMmZvkulUZkOP9ULuPsV2UIjIuhwzKinbCqGX9rS7stMpcYPToliFldcyt/Q==
X-Received: by 2002:a19:8ac3:: with SMTP id m186mr10047964lfd.131.1591530616647;
        Sun, 07 Jun 2020 04:50:16 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:2fcc:315b:7164:73a6:b557? ([2a00:1370:812d:2fcc:315b:7164:73a6:b557])
        by smtp.gmail.com with ESMTPSA id o19sm2837455ljc.23.2020.06.07.04.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 04:50:15 -0700 (PDT)
Subject: Re: balance + ENOFS -> readonly filesystem
To:     kreijack@inwind.it,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20200607051217.GE12913@qmqm.qmqm.pl>
 <88e8b58e-9a4c-1f3e-4b08-8a56de191dd4@gmx.com>
 <20200607083452.GA9208@qmqm.qmqm.pl>
 <41bfa30e-cc9f-5f26-3aab-c141a9e3aa91@libero.it>
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
Message-ID: <9c219e9c-d398-444d-f817-9160b9cc8520@gmail.com>
Date:   Sun, 7 Jun 2020 14:50:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <41bfa30e-cc9f-5f26-3aab-c141a9e3aa91@libero.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

07.06.2020 13:09, Goffredo Baroncelli пишет:
>>
>> Unallocated:
>>     /dev/mapper/btrfs1           1.02MiB
>>     /dev/mapper/btrfs2         930.49GiB
> 
> The old disk is full. And the fact that Metadata has a raid1 profile
> prevent further metadata allocation/reshape.
> The filesystem goes RO after the mount ? If no a simple balance of
> metadata should be enough; pay attention to select
> "single" profile for metadata for this first attempt.
> 
> # btrfs balance start -mconvert=single <mnt-point>
> 
> This should free about 4G from the old disk. Then, balance the data
> 

E-h-h ... how btrfs knows it should free 4G from the old and not form
the new disk? I guess it is old request to allow explicitly select
"victim" and "target" devices during balance.

IOW can we rely on btrfs doing "the right thing" always or is just
coincidence?
