Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BABF132B73
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 17:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgAGQw4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 11:52:56 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45702 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgAGQw4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 11:52:56 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007GZ1Xc086820;
        Tue, 7 Jan 2020 16:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=kUQXfk8ks+QyevendhJaCCyR3wenQ3Hd/K0iGrKdWn8=;
 b=OW+IGLjdLcI72yhZdcKAswAT+w3yYOIMmU1q5VNvmELZzw9dX+ISn3GFJmLMTo92lzEJ
 VWY+oj3vLUZsXG4+Am90PUpQyuvSId15xzdVxYZRxximzz97lampNMUPTPJc104kgF/s
 kkExFYzkxWpt5pthnBAUBqwL2CpFdvZ05RLLngUZr47Mlc2MS77hL0m808FkvxUmkTrC
 yjI9xI6+yHC6JFeUg0/nzwn46OgvSPjvQwpMdh74Yq9fBHARduKze7+DnKRC/0up7bDg
 IIJp2eNr3dcnhf7DlHhUQO0PHS0PbPTrde1m8hMwNC1m7uA7vfwh7JBEqsBUndN8dRAs 3w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xajnpxstd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 16:52:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 007GcfYh146934;
        Tue, 7 Jan 2020 16:52:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2xcqbfcrkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 16:52:52 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 007GqoWG014885;
        Tue, 7 Jan 2020 16:52:51 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 08:52:50 -0800
Date:   Tue, 7 Jan 2020 19:52:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [bug report] btrfs: get rid of trivial __btrfs_lookup_bio_sums()
 wrappers
Message-ID: <20200107165243.GE27042@kadam>
References: <20200107081058.35la6yytkwly2h52@kili.mountain>
 <20200107161046.GZ3929@twin.jikos.cz>
 <20200107164108.GB3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107164108.GB3929@twin.jikos.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070136
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 07, 2020 at 05:41:09PM +0100, David Sterba wrote:
> On Tue, Jan 07, 2020 at 05:10:46PM +0100, David Sterba wrote:
> > On Tue, Jan 07, 2020 at 11:10:58AM +0300, Dan Carpenter wrote:
> > >    276                  diff = diff * csum_size;
> > >    277                  count = min_t(int, nblocks, (item_last_offset - disk_bytenr) >>
> > >    278                                              inode->i_sb->s_blocksize_bits);
> > >    279                  read_extent_buffer(path->nodes[0], csum,
> > >    280                                     ((unsigned long)item) + diff,
> > >    281                                     csum_size * count);
> > >    282  found:
> > >    283                  csum += count * csum_size;
> > >    284                  nblocks -= count;
> > >    285  next:
> > >    286                  while (count--) {
> > >                                ^^^^^^^
> > > This loop exits with count set to -1.
> > > 
> > >    287                          disk_bytenr += fs_info->sectorsize;
> > >    288                          offset += fs_info->sectorsize;
> > >    289                          page_bytes_left -= fs_info->sectorsize;
> > >    290                          if (!page_bytes_left)
> > >    291                                  break; /* move to next bio */
> > >    292                  }
> > >    293          }
> > >    294  
> > >    295          WARN_ON_ONCE(count);
> > >                              ^^^^^
> > > Originally this warning was next to the line 291 so it should probably
> > > be "WARN_ON_ONCE(count >= 0);"  This WARN is two years old now and no
> > > one has complained about it at run time.  That's very surprising to me
> > > because I would have expected count to -1 in the common case.
> > 
> > Possible explanation I see is that the "if (!page_bytes_left)" does not
> > let the count go from 0 -> -1 and exits just in time. I'm runing a test
> > to see if it's true.
> 
> It is. It's not very clear from the context, count is set up so that it
> matches page_bytes_left decrements. So using "count--" is not completely
> wrong, but it is confusing and relying on other subtle behaviour. It
> should be either --count or the decrement moved to out of the condition.
> 
> I can write the patch and add you as reporter or you can send the patch
> as you did the analysis in the first place.

Could you add me as the reporter?  I'd feel uncomfortable changing the
code here when I don't really understand it.

regards,
dan carpenter
